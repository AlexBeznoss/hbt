# [Honeybadger Take Home Project](https://honeybadger.notion.site/honeybadger/Take-home-project-for-Software-Developer-position-2023-fee9be3cd8454e1fb61e53f0172ff2e8)
## How to run localy?

- `bin/setup` - install all dependencies 
- `bin/rails credentials:show --environment=test` - show structure of required credentials
- Run `bin/rails credentials:edit` to change your credentials according to structure from last step
- `foremant start` - runs rails server and sidekiq
- Make request to POST localhost:3000/webhooks

## How to deploy?

- `bin/rails credentials:edit --environment=production` - to prepare production credentials
- Update .env file 
- Update config/deploy.yml with info about your docker registry, server ip, etc.
- Run `mrsk deploy`

## Notes, comments assumptions:

- To be honest, rails feels like overkill, but I was not confident enough that I could make it faster than 2 hours on something else and without quality neglection.
- My assumption is that we don't really need to save in DB anything and just send slack message async is good enough.
