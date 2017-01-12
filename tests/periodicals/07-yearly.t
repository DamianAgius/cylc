#!/bin/bash
# THIS FILE IS PART OF THE CYLC SUITE ENGINE.
# Copyright (C) 2008-2017 NIWA
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# Test Yearly cycling
. $(dirname $0)/test_header
#-------------------------------------------------------------------------------
set_test_number 1
#-------------------------------------------------------------------------------
install_suite $TEST_NAME_BASE Yearly
#-------------------------------------------------------------------------------
TEST_NAME=$TEST_NAME_BASE-run
perl -pi -e 's/(Initial point: ).*$/${1}2012/' $TEST_DIR/$SUITE_NAME/reference.log
suite_run_ok $TEST_NAME cylc run --reference-test --debug $SUITE_NAME
#-------------------------------------------------------------------------------
purge_suite $SUITE_NAME
