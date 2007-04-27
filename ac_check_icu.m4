##### http://autoconf-archive.cryp.to/ac_check_icu.html
#
# SYNOPSIS
#
#   AC_CHECK_ICU(version, action-if, action-if-not)
#
# DESCRIPTION
#
#   Defines ICU_LIBS, ICU_CFLAGS, ICU_CXXFLAGS. See icu-config(1) man
#   page.
#
# LAST MODIFICATION
#
#   2005-09-20
#
# COPYLEFT
#
#   Copyright (c) 2005 Akos Maroy <darkeye@tyrell.hu>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_CHECK_ICU], [
  succeeded=no

  if test -z "$ICU_CONFIG"; then
    AC_PATH_PROG(ICU_CONFIG, icu-config, no)
  fi

  if test "$ICU_CONFIG" = "no" ; then
    echo "*** The icu-config script could not be found. Make sure it is"
    echo "*** in your path, and that taglib is properly installed."
    echo "*** Or see http://ibm.com/software/globalization/icu/"

            # added 2007-04-27 Marc Cromme
            HAVE_ICU=0
            # end added
  else
    ICU_VERSION=`$ICU_CONFIG --version`
    AC_MSG_CHECKING(for ICU >= $1)
        VERSION_CHECK=`expr $ICU_VERSION \>\= $1`
        if test "$VERSION_CHECK" = "1" ; then
            AC_MSG_RESULT(yes)
            succeeded=yes

            # added 2007-04-27 Marc Cromme
            HAVE_ICU=1

            AC_MSG_CHECKING(ICU_CPPFLAGS)
            ICU_CPPFLAGS=`$ICU_CONFIG --cppflags`" -DHAVE_ICU=1"
            AC_MSG_RESULT($ICU_CPPFLAGS)
            # end added

            AC_MSG_CHECKING(ICU_CFLAGS)
            ICU_CFLAGS=`$ICU_CONFIG --cflags`
            AC_MSG_RESULT($ICU_CFLAGS)

            AC_MSG_CHECKING(ICU_CXXFLAGS)
            ICU_CXXFLAGS=`$ICU_CONFIG --cxxflags`
            AC_MSG_RESULT($ICU_CXXFLAGS)

            AC_MSG_CHECKING(ICU_LIBS)
            ICU_LIBS=`$ICU_CONFIG --ldflags`
            AC_MSG_RESULT($ICU_LIBS)
        else
            # added 2007-04-27 Marc Cromme
            ICU_CPPFLAGS=""
            # end added
            ICU_CFLAGS=""
            ICU_CXXFLAGS=""
            ICU_LIBS=""
            ## If we have a custom action on failure, don't print errors, but
            ## do set a variable so people can do so.
            ifelse([$3], ,echo "can't find ICU >= $1",)
        fi

        # added 2007-04-27 Marc Cromme
        AC_SUBST(HAVE_ICU)
        AC_SUBST(ICU_CPPFLAGS)
        # end added
        AC_SUBST(ICU_CFLAGS)
        AC_SUBST(ICU_CXXFLAGS)
        AC_SUBST(ICU_LIBS)
  fi

  if test $succeeded = yes; then
     ifelse([$2], , :, [$2])
  else
     ifelse([$3], , AC_MSG_ERROR([Library requirements (ICU) not met.]), [$3])
  fi
])
