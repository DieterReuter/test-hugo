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

```bash
./build.sh
```
And hit `save` a couple of time until `Drone.io` says our build definition is saved.

Later we'll come back to this configuration page to define some ENV variables with our GitHub credentials for pushing back the generated static web content to our `gh-pages`.


## 4. Create a GitHub Token for pushing back our static web content
Click this [link](https://github.com/settings/tokens/new) to generate a new personal access token. You might need to re-enter your password.

![screen1](/images/01-create-github-access-token-public-repo.png)
That's right, just `public_repo`. If your repository is private, you can set `repo` instead.

Now copy the generated token.
![screen2](/images/02-copy-github-access-token.png)

This token we'll define as an ENV variable within the Drone.io build setting. Then it's available within our build step but it's hidden for the public.
![screen3](/images/03-paste-github-access-token-as-env-to-drone-io.png)


## 5. Ensure we have enabled `gh-pages`

`GitHub Pages` is just another branch `gh-pages` of your repo.
You want to make sure your branch `gh-pages` already exists.
```bash
git checkout master
git checkout -b gh-pages
git push origin -u gh-pages
git checkout master
```
Easy enough, isn't it?


## 6. Creating a basic Hugo site
First we define not to include the generated static web page to save in out git repo.
```bash
echo "/hugo-website/public" >> .gitignore
```

Create a new Hugo web site
```bash
hugo new site ./hugo-website
cd ./hugo-website
```

Now we do have a new `config.toml` Hugo configuration file.
```toml
baseurl = "http://yourSiteHere/"
languageCode = "en-us"
title = "My New Hugo Site"
```

Install a specific theme.
```bash
mkdir themes
cd themes
git clone https://github.com/SenjinDarashiva/hugo-uno
cd ..
```

```bash
hugo new about.md
hugo new posts/first.md
```

Let's test run the new Hugo website.
```bash
open http://localhost:1313/
hugo server --theme=hugo-uno --buildDrafts
```

And now let's publish it.
```bash
hugo --theme=hugo-uno --buildDrafts
```

---

The MIT License (MIT)

Copyright (c) 2015 Dieter Reuter
