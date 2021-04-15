from naive.math import EmptyListError, average

import pytest


def test_average_throws_with_empty_list():
    with pytest.raises(EmptyListError):
        average([])


def test_average_list_of_size_1():
    assert average([-5.0]) == -5.0
    assert average([-1.0]) == -1.0
    assert average([ 0.0]) ==  0.0
    assert average([ 1.0]) ==  1.0
    assert average([ 5.0]) ==  5.0


def test_average_list_of_same_values():
    assert average([-17.125, -17.125]) == -17.125
    assert average([-3.75, -3.75, -3.75]) == -3.75
    assert average([0.0, 0.0, 0.0, 0.0]) == 0.0
    assert average([3.75, 3.75, 3.75]) == 3.75
    assert average([17.125, 17.125]) == 17.125


def test_average_list_of_opposite_values():
    assert average([-1.75, 1.75]) == 0.0
    assert average([-1.75, -1.75, 1.75, 1.75]) == 0.0
    assert average([-75.125, 75.125]) == 0.0
    assert average([-75.125, -75.125, 75.125, 75.125]) == 0.0


def test_average_list_of_random_values():
    assert average([-17.125, -3.75, 5.0, 75.125]) == 14.8125


def test_average_int_args_yield_same_result_as_floats():
    assert average([-5, 0, 1, 3]) == average([-5.0, 0.0, 1.0, 3.0])


def test_average_no_difference_between_list_and_tuple():
    assert average([-17.125, -3.75, 5.0, 75.125]) \
        == average((-17.125, -3.75, 5.0, 75.125))
