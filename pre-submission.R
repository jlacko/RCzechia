# pre-submission routine

rhub::platforms() # to find an appropriate macos version

rhub::check_on_windows()
rhub::check_for_cran(platforms = "macos-highsierra-release")
devtools::check_win_release()
devtools::check_win_devel()

# once ready
devtools::release()
