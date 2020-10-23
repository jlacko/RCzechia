# pre-submission routine

rhub::platforms() # to find an appropriate macos version

rhub::check_on_windows()
rhub::check_for_cran(platforms = "macos-highsierra-release-cran")
rhub::check_for_cran(platforms = "solaris-x86-patched")
devtools::check_win_release()
devtools::check_win_devel()
devtools::check_win_oldrelease()

# once ready
devtools::release()
