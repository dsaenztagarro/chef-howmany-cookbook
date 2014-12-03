name             'my-rails'
maintainer       'David Saenz Tagarro'
maintainer_email 'david.saenz.tagarro@gmail.com '
license          'All rights reserved'
description      'Installs/Configures howmany'
long_description 'Installs/Configures howmany'
version          '0.1.0'

# Fetching dependencies can fail from time to time due to the fact that
# Berkshelf API service is unavailable. To check status:
# https://api.berkshelf.com/status

# Environment
# depends 'my-environment'

# Database
depends 'database'
depends 'postgresql'

# howmany-backend
depends 'rvm'

# howmany-frontend
depends 'nodejs'

