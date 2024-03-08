#
# This source file is part of the EdgeDB open source project.
#
# Copyright 2018-present MagicStack Inc. and the EdgeDB authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

CREATE MODULE math;


CREATE FUNCTION
math::abs(x: std::anyreal) -> std::anyreal
{
    CREATE ANNOTATION std::description :=
        'Return the absolute value of the input *x*.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'abs';
};


CREATE FUNCTION
math::ceil(x: std::int64) -> std::int64
{
    CREATE ANNOTATION std::description := 'Round up to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT "x";';
};


CREATE FUNCTION
math::ceil(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Round up to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT ceil("x");'
};


CREATE FUNCTION
math::ceil(x: std::bigint) -> std::bigint
{
    CREATE ANNOTATION std::description := 'Round up to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT "x";'
};


CREATE FUNCTION
math::ceil(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Round up to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT ceil("x");'
};


CREATE FUNCTION
math::floor(x: std::int64) -> std::int64
{
    CREATE ANNOTATION std::description := 'Round down to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT "x";';
};


CREATE FUNCTION
math::floor(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Round down to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT floor("x");';
};


CREATE FUNCTION
math::floor(x: std::bigint) -> std::bigint
{
    CREATE ANNOTATION std::description := 'Round down to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT "x";'
};


CREATE FUNCTION
math::floor(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Round down to the nearest integer.';
    SET volatility := 'Immutable';
    USING SQL 'SELECT floor("x");';
};


CREATE FUNCTION
math::ln(x: std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the natural logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'ln';
};


CREATE FUNCTION
math::ln(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the natural logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'ln';
};


CREATE FUNCTION
math::ln(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the natural logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'ln';
};


CREATE FUNCTION
math::lg(x: std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the base 10 logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'log';
};


CREATE FUNCTION
math::lg(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the base 10 logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'log';
};


CREATE FUNCTION
math::lg(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the base 10 logarithm of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'log';
};


CREATE FUNCTION
math::log(x: std::decimal, NAMED ONLY base: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the logarithm of the input value in the specified *base*.';
    SET volatility := 'Immutable';
    USING SQL $$
    SELECT log("base", "x")
    $$;
};


CREATE FUNCTION
math::sqrt(x: std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the square root of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sqrt';
};


CREATE FUNCTION
math::sqrt(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the square root of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sqrt';
};


CREATE FUNCTION
math::sqrt(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the square root of the input value.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sqrt';
};

# math::mean
# -----------
# The mean function returns an empty set if the input is empty set. On
# all other inputs it returns the mean for that input set.
CREATE FUNCTION
math::mean(vals: SET OF std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the arithmetic mean of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'avg';
    SET error_on_null_result := 'invalid input to mean(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::mean(vals: SET OF std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the arithmetic mean of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'avg';
    # SQL 'avg' returns numeric on integer inputs.
    SET force_return_cast := true;
    SET error_on_null_result := 'invalid input to mean(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::mean(vals: SET OF std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the arithmetic mean of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'avg';
    SET error_on_null_result := 'invalid input to mean(): not ' ++
                                'enough elements in input set';
};


# math::stddev
# ------------
CREATE FUNCTION
math::stddev(vals: SET OF std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the sample standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev';
    SET error_on_null_result := 'invalid input to stddev(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::stddev(vals: SET OF std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the sample standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev';
    # SQL 'stddev' returns numeric on integer inputs.
    SET force_return_cast := true;
    SET error_on_null_result := 'invalid input to stddev(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::stddev(vals: SET OF std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the sample standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev';
    SET error_on_null_result := 'invalid input to stddev(): not ' ++
                                'enough elements in input set';
};


# math::stddev_pop
# ----------------
CREATE FUNCTION
math::stddev_pop(vals: SET OF std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the population standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev_pop';
    SET error_on_null_result := 'invalid input to stddev_pop(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::stddev_pop(vals: SET OF std::int64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the population standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev_pop';
    # SQL 'stddev_pop' returns numeric on integer inputs.
    SET force_return_cast := true;
    SET error_on_null_result := 'invalid input to stddev_pop(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::stddev_pop(vals: SET OF std::float64) -> std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the population standard deviation of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'stddev_pop';
    SET error_on_null_result := 'invalid input to stddev_pop(): not ' ++
                                'enough elements in input set';
};


# math::var
# --------------
CREATE FUNCTION
math::var(vals: SET OF std::decimal) -> OPTIONAL std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the sample variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'variance';
    SET error_on_null_result := 'invalid input to var(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::var(vals: SET OF std::int64) -> OPTIONAL std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the sample variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'variance';
    # SQL 'var' returns numeric on integer inputs.
    SET force_return_cast := true;
    SET error_on_null_result := 'invalid input to var(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::var(vals: SET OF std::float64) -> OPTIONAL std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the sample variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'variance';
    SET error_on_null_result := 'invalid input to var(): not ' ++
                                'enough elements in input set';
};


# math::var_pop
# -------------
CREATE FUNCTION
math::var_pop(vals: SET OF std::decimal) -> OPTIONAL std::decimal
{
    CREATE ANNOTATION std::description :=
        'Return the population variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'var_pop';
    SET error_on_null_result := 'invalid input to var_pop(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::var_pop(vals: SET OF std::int64) -> OPTIONAL std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the population variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'var_pop';
    # SQL 'var_pop' returns numeric on integer inputs.
    SET force_return_cast := true;
    SET error_on_null_result := 'invalid input to var_pop(): not ' ++
                                'enough elements in input set';
};


CREATE FUNCTION
math::var_pop(vals: SET OF std::float64) -> OPTIONAL std::float64
{
    CREATE ANNOTATION std::description :=
        'Return the population variance of the input set.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'var_pop';
    SET error_on_null_result := 'invalid input to var_pop(): not ' ++
                                'enough elements in input set';
};


# math::acos
# ----------
CREATE FUNCTION
math::acos(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse cosine, result in radians.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'acos';
};


# math::acosd
# ----------
CREATE FUNCTION
math::acosd(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Inverse cosine, result in degrees.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'acosd';
};


CREATE FUNCTION
math::acosd(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse cosine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'acosd';
};


# math::asin
# ----------
CREATE FUNCTION
math::asin(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse sine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'asin';
};


CREATE FUNCTION
math::asin(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse sine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'asin';
};


# math::asind
# ----------
CREATE FUNCTION
math::asind(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse sine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'asind';
};


CREATE FUNCTION
math::asind(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse sine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'asind';
};


# math::atan
# ----------
CREATE FUNCTION
math::atan(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan';
};


CREATE FUNCTION
math::atan(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan';
};


# math::atand
# ----------
CREATE FUNCTION
math::atand(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atand';
};


CREATE FUNCTION
math::atand(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atand';
};


# math::atan2
# ----------
CREATE FUNCTION
math::atan2(x: std::float64, y: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent of y/x, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan2';
};


CREATE FUNCTION
math::atan2(x: std::decimal, y: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent of y/x, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan2';
};


# math::atan2d
# ----------
CREATE FUNCTION
math::atan2d(x: std::float64, y: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent of y/x, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan2d';
};


CREATE FUNCTION
math::atan2d(x: std::decimal, y: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Inverse tangent of y/x, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'atan2d';
};


# math::cos
# ----------
CREATE FUNCTION
math::cos(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cosine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cos';
};


CREATE FUNCTION
math::cos(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cosine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cos';
};


# math::cosd
# ----------
CREATE FUNCTION
math::cosd(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cosine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cosd';
};


CREATE FUNCTION
math::cosd(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cosine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cosd';
};


# math::cot
# ----------
CREATE FUNCTION
math::cot(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cotangent, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cot';
};


CREATE FUNCTION
math::cot(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cotangent, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cot';
};


# math::cotd
# ----------
CREATE FUNCTION
math::cotd(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cotangent, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cotd';
};


CREATE FUNCTION
math::cotd(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cotangent, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cotd';
};


# math::sin
# ----------
CREATE FUNCTION
math::sin(x: std::decimal) -> std::float64
{
    CREATE ANNOTATION std::description := 'Sine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sin';
};


CREATE FUNCTION
math::sin(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Sine, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sin';
};


# math::sind
# ----------
CREATE FUNCTION
math::sind(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Sine, result in degrees.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'sind';
};


CREATE FUNCTION
math::sind(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Sine, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'sind';
};


# math::tan
# ----------
CREATE FUNCTION
math::tan(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Tangent, result in radians.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'tan';
};


CREATE FUNCTION
math::tan(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Tangent, result in radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'tan';
};


# math::tand
# ----------
CREATE FUNCTION
math::tand(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Tangent, result in degrees.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'tand';
};


CREATE FUNCTION
math::tand(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Tangent, result in degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'tand';
};


# math::pi
# --------
CREATE FUNCTION
math::pi() -> std::float64
{
    CREATE ANNOTATION std::description := 'Approximate value of π.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'pi';
};

# math::cbrt
# ----------
CREATE FUNCTION
math::cbrt(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Cube root.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'cbrt';
};


CREATE FUNCTION
math::cbrt(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Cube root.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'cbrt';
};


# math::degrees
# ----------
CREATE FUNCTION
math::degrees(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Convert radians input value to degrees.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'degrees';
};


CREATE FUNCTION
math::degrees(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Convert radians input value to degrees.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'degrees';
};


# math::radians
# ----------
CREATE FUNCTION
math::radians(x: std::float64) -> std::float64
{
    CREATE ANNOTATION std::description := 'Convert degrees input value to radians.';
    SET volatility := 'Immutable';
    USING SQL FUNCTION 'radians';
};


CREATE FUNCTION
math::radians(x: std::decimal) -> std::decimal
{
    CREATE ANNOTATION std::description := 'Convert degrees input value to radians.';
    SET volatility := 'Immutable';
    SET force_return_cast := true;
    USING SQL FUNCTION 'radians';
};