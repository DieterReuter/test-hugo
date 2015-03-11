[![Build Status](https://drone.io/github.com/DieterReuter/test-hugo/status.png)](https://drone.io/github.com/DieterReuter/test-hugo/latest)

# test-hugo
Test Hugo, deploy to gh_pages using Drone.io

This is a quick step-by-step walkthrough to create a blog with [Hugo](http://gohugo.io), store it as a GitHub repo, with automated deployment via [Drone.io](https://drone.io) to my `GitHub Pages`.


## 1. Create a new GitHub repo
name = `test-hugo`


## 2. Clone repo to desktop
Add some details to the README.md and push it to GH master.


## 3. Create an account at [Drone.io](https://drone.io)
Just login with your GitHub account, which is dead easy. If you're using a public repo you can use the free plan.

Use this deep link for a direct login with github account: https://drone.io/auth/login/github
Klick on `New Project` then `GitHub`, select repo `dieterreuter/test-hugo` and configure the repo for a GOLANG build step. Hugo is build with Go and therefor we use the appropriate build pipeline.

Now let's define our build steps, we just use a dedicated build script, which we keep inside our source repo.
```
./build.sh
```
And hit `save` a couple of time until `Drone.io` says our build definition is saved.

Later we'll come back to this configuration page to define some ENV variables with our GitHub credentials for pushing back the generated static web content to our `gh-pages`.


## 4. Create a GitHub Token for pushing back our static web content
Click this [link](https://github.com/settings/tokens/new) to generate a new personal access token. You might need to re-enter your password.
![screen1](/images/01-create-github-access-token.png)

Now copy the generated token.
![screen2](/images/02-copy-github-access-token.png)

This token we define as an ENV variable within the Drone.io build setting.
![screen3](/images/03-paste-github-access-token-as-env-to-drone-io.png)


## 5. Creating a basic Hugo site
First we define not to include the generated static web page to save in out git repo.
```bash
echo "/public" >> .gitignore
```

---

The MIT License (MIT)

Copyright (c) 2015 Dieter Reuter
