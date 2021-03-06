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
# Test cylc print doesn't skip special names at root level,
# e.g. "~/cylc-run/work"
. "$(dirname "$0")/test_header"
set_test_number 3

init_suite "${TEST_NAME_BASE}" <<'__SUITE_RC__'
[meta]
    title = the quick brown fox
[scheduling]
    [[dependencies]]
        graph = a => b => c
[runtime]
    [[a,b,c]]
        script = true
__SUITE_RC__
RUND="$(cylc get-global-config --print-run-dir)"
ln -sf "${SUITE_NAME}" "${RUND}/work"

run_ok "${TEST_NAME_BASE}-print" cylc print
contains_ok "${TEST_NAME_BASE}-print.stdout" <<__OUT__
work | the quick brown fox | ${TEST_DIR}/${SUITE_NAME}
__OUT__
cmp_ok "${TEST_NAME_BASE}-print.stderr" <'/dev/null'

rm -f "${RUND}/work"
purge_suite "${SUITE_NAME}"
exit
