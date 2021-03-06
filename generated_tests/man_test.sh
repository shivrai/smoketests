#
# Copyright 2017 Shivansh Rai
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD$
#

atf_test_case h_flag
h_flag_head()
{
	atf_set "descr" "Verify the usage of option 'h'"
}

h_flag_body()
{
	atf_check -s exit:0 -o inline:"Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -h
}

atf_test_case invalid_usage
invalid_usage_head()
{
	atf_set "descr" "Verify that an invalid usage with a supported option produces a valid error message"
}

invalid_usage_body()
{
	atf_check -s not-exit:0 -e inline:"What manual page do you want?
" man -a
	atf_check -s not-exit:0 -e inline:"Illegal option -C
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -C
	atf_check -s not-exit:0 -e inline:"Illegal option -c
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -c
	atf_check -s not-exit:0 -e match:"$usage_output" man -f
	atf_check -s not-exit:0 -e match:"$usage_output" man -k
	atf_check -s not-exit:0 -e inline:"Illegal option -l
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -l
	atf_check -s not-exit:0 -e inline:"No arg for -M option
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -M
	atf_check -s not-exit:0 -e inline:"No arg for -m option
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -m
	atf_check -s not-exit:0 -e inline:"No arg for -S option
Usage:
 man [-adho] [-t | -w] [-M manpath] [-P pager] [-S mansect]
     [-m arch[:machine]] [-p [eprtv]] [mansect] page [...]
 man -f page [...] -- Emulates whatis(1)
 man -k page [...] -- Emulates apropos(1)
" man -S
	atf_check -s not-exit:0 -e inline:"What manual page do you want?
" man -w
}

atf_test_case no_arguments
no_arguments_head()
{
	atf_set "descr" "Verify that man(1) fails and generates a valid output when no arguments are supplied"
}

no_arguments_body()
{
	atf_check -s not-exit:0 -e inline:"What manual page do you want?
" man
}

atf_init_test_cases()
{
	atf_add_test_case h_flag
	atf_add_test_case invalid_usage
	atf_add_test_case no_arguments
}
