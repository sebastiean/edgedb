##
# Copyright (c) 2008-2010 Sprymix Inc.
# All rights reserved.
#
# See LICENSE for details.
##


import uuid


from semantix.caos import types as caos_types


def check_type(variable, type):
    if not isinstance(type, str):
        raise Exception('check_type: type parameter must be string')

    if variable is None:
        return True

    if type == 'str':
        return isinstance(variable, str)

    if type == 'int':
        return isinstance(variable, int)

    if type == 'float':
        return isinstance(variable, float)

    if type == 'bool':
        return isinstance(variable, bool)

    if type == 'list':
        return isinstance(variable, list)

    if type == 'uuid':
        return isinstance(variable, uuid.UUID)

    if type == 'none':
        return variable is None

    raise Exception('check_type: checking on unknown type: %s' % type)


class DatasourceError(Exception):
    pass


class Datasource(object):
    @classmethod
    def prepare_class(cls, context, descriptor):
        cls.descriptor = descriptor

    def __init__(self):
        self.params = self.descriptor.get('params', None)

    def describe_output(self):
        raise NotImplementedError

    def check_type(self, name, value, type):
        if check_type(value, type):
            return value
        else:
            raise ValueError('invalid parameter type')

    def _filter_params(self, params, filters=None):
        if self.params is None:
            return {}

        filtered = {}

        for name, config in self.params.items():
            value = None

            if name in params:
                value = params[name]

                try:
                    value = self.check_type(name, value, config['type'])
                except ValueError as e:
                    raise DatasourceError('datatype check failed, param: @name=%s, @value=%s, expected type: %s' %
                                          (name, value, config['type'])) from e
            else:
                if 'default' in config:
                    value = self.coerce_default_value(name, config['default'], config['type'])
                else:
                    raise DatasourceError('expected required param: @name=%s' % name)

            filtered[name] = value

        if filters:
            extra_filters = filters.copy()

            for name, value in filters.items():
                if name not in self.params:
                    filtered['__filter%s' % name] = value
                else:
                    filtered[name] = self.check_type(name, value, self.params[name]['type'])
                    del extra_filters[name]
        else:
            extra_filters = None

        return filtered, extra_filters

    def fetch(self, *, _filters=None, _sort=None, **params):
        raise NotImplementedError

    def coerce_default_value(self, name, value, type):
        return value


class CaosDatasource(Datasource):
    def __init__(self, session):
        super().__init__()
        self.session = session

    def check_type(self, name, value, typ):
        if typ == 'any' or value is None:
            return value

        is_sequence = isinstance(typ, (tuple, list))

        if is_sequence:
            typ = typ[0]

        type = self.session.schema.get(typ)

        values = (value,) if not is_sequence else value
        result = []

        for val in values:
            if isinstance(value, type):
                result.append(value)
            elif isinstance(type, caos_types.AtomClass) and issubclass(type, value.__class__):
                result.append(value)
            else:
                result.append(self.coerce_default_value(name, value, typ))

        if not is_sequence:
            return result[0]

        return result

    def coerce_default_value(self, name, value, type):
        if type == 'any' or value is None:
            return value
        type = self.session.schema.get(type)
        if isinstance(value, type):
            return value
        elif isinstance(type, caos_types.AtomClass):
            value = type(value)
        else:
            raise DatasourceError('could not coerce default value for "%s" parameter' % name)
        return value


class Result:
    def __init__(self, result, total_records):
        self.result = result
        self.total_records = total_records

    def __iter__(self):
        return iter(self.result)

    def get_total(self):
        return self.total_records
