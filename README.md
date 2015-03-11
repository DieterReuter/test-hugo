[![Build Status](https://drone.io/github.com/DieterReuter/test-hugo/status.png)](https://drone.io/github.com/DieterReuter/test-hugo/latest)

# test-hugo
Test Hugo, deploy to `gh-pages` using Drone.io

This is a quick step-by-step walkthrough to create a blog with [Hugo](http://gohugo.io), store it as a GitHub repo, with automated deployment via [Drone.io](https://drone.io) to your `GitHub Pages`.


## 1. Create a new GitHub repo
Name = `test-hugo`

Ether you can create it within the GitHub web UI, or on the command line.
```bash
mkdir -p test-hugo
cd test-hugo
git init
```

And add some details to the README.md and push it back to GitHub master.
```bash
git add README.md
git commit -m "initial commit"
git push origin master
```


## 2. Create an account at [Drone.io](https://drone.io)
Just login with your GitHub account, which is dead easy. If you're using a public repo, you can use the free plan and start deploying with ease.

Use this deep link for a direct login with your github account: https://drone.io/auth/login/github, click on `New Project`, then `GitHub`, select your repo name (here is mine `dieterreuter/test-hugo`) and configure the repo for a GOLANG build step. Hugo is build with Go and therefore we use the appropriate build pipeline.

Now let's define our build steps properly. We're just using a dedicated build script, which we'll keep inside our source repo. I really like transparency and include all build steps within the repo itself, but it's on your choice to hide some sensitive code and credentials.

```bash
./build.sh
```
Now hit `save` a couple of times, until `Drone.io` says, your build definition is saved.

Later we'll come back to this configuration page to define some ENV variables with our GitHub credentials for pushing back the generated static web content to our `gh-pages`. These credentials or GitHub tokens SHOULD EVER been defines as an ENV variable, and also keep in mind, don't log them into the build log. But if this happens during your dev cycle, don't worry, that's no problem at all. Just change your code, delete them in your GitHub account and just create a new one - this takes you a few minutes only and you're back on the save side again.


## 3. Create a GitHub Token for pushing back your static web content
Click this [link](https://github.com/settings/tokens/new) to generate a new personal access token. You might need to re-enter your password for your GitHub account.

![screen1](/images/01-create-github-access-token-public-repo.png)
That's right, we just use `public_repo`. If your repository is private, you can set `repo` instead.

Now copy the generated token.
![screen2](/images/02-copy-github-access-token.png)

This token we'll define as an ENV variable within the Drone.io build settings. Then it's available within our build step, but it's hidden for the public.
![screen3](/images/03-paste-github-access-token-as-env-to-drone-io.png)


## 4. Ensure we have enabled `gh-pages`

`GitHub Pages` is just another branch `gh-pages` of your repo. You want to make sure your branch `gh-pages` already exists. Just execute the following bash script and you'll be sure the branch `gh-pages` exists.
```bash
git checkout master
git checkout -b gh-pages
git push origin -u gh-pages
git checkout master
```
Easy enough, isn't it?


## 5. Creating a basic Hugo site
First you define not to include the generated static web page to save in your git repo.
```bash
echo "/hugo-website/public" >> .gitignore
```

Create a new Hugo web site.
```bash
hugo new site ./hugo-website
cd ./hugo-website
```

Now you have a new and default `config.toml` Hugo configuration file.
```toml
baseurl = "http://yourSiteHere/"
languageCode = "en-us"
title = "My New Hugo Site"
```

Let's install a specific theme.
```bash
mkdir themes
cd themes
git clone https://github.com/SenjinDarashiva/hugo-uno
cd ..
```

And create some basic posts.
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


## 6. Let's fire it up, deploy your blog

After all, you can commit your changes to GitHub and watch the build server deploying your first Hugo blog site.
```bash
git add .
git commit -m "my first awesome blog with Hugo"
git push origin master
hub browse
```

Now, it's up to you to pimp your Hugo blog. And with every single `git push` you can be sure, `Drone.io` builds your latest blog version instantly, constantly and in an incredible short time frame.

Enjoy it, and support the [Hugo](http://gohugo.io) project, please.

Thanks for your curiosity and patience. And don't forget to send me your feedback!
---

The MIT License (MIT)

Copyright (c) 2015 Dieter Reuter
