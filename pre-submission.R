# pre-submission routine

devtools::check_win_release()
devtools::check_win_devel()
devtools::check_win_oldrelease()

# once ready
devtools::release()

# internet docs - package down
pkgdown::build_site()

# upload docs to interwebs
system('aws s3 sync ./docs s3://rczechia.jla-data.net')
system('aws cloudfront create-invalidation --distribution-id E18KZBS7UJYD5I --paths "/*"')
