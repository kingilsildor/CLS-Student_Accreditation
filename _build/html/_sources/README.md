# Jupyter Book Tutorial

In this tutorial, we will teach you how to create a Jupyter book and deploy it online.
This page is written in markdown, which also serves as an example.
All the content on this website is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Table of contents
- [Step 1: Install conda](#s1)
- [Step 2: Install Jupyter Book](#s2)
- [Step 3: Build the book locally](#s4)
- [Step 4: Deploy the book online](#s5)
- [Update the website content](#update)
- [Troubleshooting](#ts)

## Step 1: Install conda
<a name="s1"></a>

The first step is installing the conda virtual environment using [miniconda](https://docs.conda.io/en/main/miniconda.html) or [anaconda](https://www.anaconda.com/).
Pick either one of them and follow the instructions on the website to install conda so that you can use the `conda` command on your terminal.

:::{important}
If you already have `conda` installed on your machine, you can skip this step. Check your `conda` installation by running the following command:
```sh
conda --version
```
If `conda` is installed, you should see a printed message with the version number.
:::

We recommend using miniconda since it is light-weighted, and you can avoid waiting for a long time to install many packages that may not be necessary.
If you already have the conda environment ready on your machine, you can skip this step.

For Mac users, you can also install miniconda using the [Homebrew](https://brew.sh/) package manager, as documented on [this page](https://formulae.brew.sh/cask/miniconda):
```sh
brew install --cask miniconda
echo 'export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"' >> ~/.bash_profile
echo '. /usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh' >> ~/.bash_profile
source ~/.bash_profile
```

:::{important}
If you are using Windows, choose the way of using the installer to set up conda (not the portable one).
When running the installation, **make sure that you need to tick the box to allow the installer to set the system environment path for conda**.
Otherwise, your terminal will not be able to find the conda command.
:::

## Step 2: Install Jupyter Book
<a name="s2"></a>

In this step, you will install the Jupyter Book package.
Notice that there are two sections in this step.
One for Mac/Linux users, and another one for Windows users.

### For Mac and Linux to install Jupyter Book
Now, create a new conda environment using the command below.
We need to install Jupyter Book in the conda environment.
```sh
conda create -n jupyterbook python=3.10
```
After you have the environment ready, activate it.
```sh
conda activate jupyterbook
```
Finally, install the packages that are needed for building and compiling notebooks.
```sh
pip install -U jupyter-book
```
Check if Jupyter Book is installed correctly using the following command.
Having no error messages means that Jupyter Book is installed correctly.
```sh
jupyter-book --help
```

### For Windows to install Jupyter Book
Windows has a known problem that the conda installation for Jupyter Book can be pending forever.
We have figured out a specific solution for this.
You need to follow the exact ordering in this part.
Missing any step or using the incorrect ordering can result in a forever-pending problem.

First, open your Git Bash that comes with the git tool installation.
If you do not know where to find your Git Bash, search it in the search bar near the Windows start button.
Do not use the Window command prompt, as it is using a different command line system and will not work for our case.

When you open the terminal, you should see a `(base)` text in the terminal, such as below:

`(base) abc@ABC-windows ~`

If you did not see it, run the following:
```sh
conda activate
```
The above command should now brings you to the `(base)` environment in conda.
If there is an error message, it is possible that your terminal does not recognize conda yet.
In this case, run the following:
```sh
conda init bash
```
**Then, close your Git Bash and re-open it.**
Now, you should be in the `(base)` conda environment.

:::{important}
Sometimes the terminal needs to load new settings after you install new things, such as conda.
Make sure that you close the entire terminal program and re-launch it.
:::

Next, create a new conda environment.
```sh
conda create -n jupyterbook python=3.10
```
After you have the environment ready, activate it.
```sh
conda activate jupyterbook
```
Then, install Jupyter Book using `conda install`. Do not use `pip install`, which will likely cause errors.
```sh
conda install -c conda-forge jupyter-book
```
This installation may take several minutes, as conda needs to solve the environment.
So please be patient and wait until it is finished.

Finally, check if Jupyter Book is installed correctly using the following command.
Having no error messages means that Jupyter Book is installed correctly.
```sh
jupyter-book --help
```

## Step 4: Build the book locally
<a name="s4"></a>

Now we are going to compile and build your book on your local machine.
Inside your conda environment, we need to install some required Python packages:
```sh
pip install -U numpy
pip install -U plotly
pip install -U pandas
pip install -U matplotlib
pip install -U seaborn
```
or
```sh
pip install -r requirements.txt
```
To build the book, run the following command.
Remember that you must go to the repository folder  (i.e., replacing `MY_REPOSITORY_NAME`) that you just cloned.
```sh
cd MY_REPOSITORY_NAME
jupyter-book build .
```
The above command only builds the newly-updated files since the last time you built the book.
Sometimes you may want to build the entire book from scratch, and you can use the following:
```sh
jupyter-book build --all .
```
After building the book, all the html files in the `_build/html/` directory will be updated.
You can then use your browser to open the files locally on your machine to view the compiled notebooks and markdown files.
You can also install a [local Apache HTTP Server](https://httpd.apache.org/) to view the files since the html files are sometimes incorrectly displayed if opened using a browser.

We also already set up the configuration file `_config.yml` and the table of content file `_toc.yml` for you.
You need to edit the `_config.yml` file to make it suitable for your use case.
For more information about how to edit them, check [this documentation](https://jupyterbook.org/en/stable/start/create.html).

## Step 5: Deploy the book online
<a name="s5"></a>

Now, we have the compiled website files ready, and we can move on to deploy the website.
We will do this using the [GitHub Pages](https://pages.github.com).

First, go to the repository folder on your computer and use `git add` to indicate that you want to push these files to the remote GitHub repository.
Replace `MY_REPOSITORY_NAME` with your repository name.
```sh
cd MY_REPOSITORY_NAME
git add .
```
Run the following to check if you add the files.
You should see green marked messages in the terminal.
```sh
git status
```
Then, commit the changes that you want to make using a message.
```sh
git commit -m "Add my first book!"
```
Next, push your code and files on your local machine to your remote repository.
```sh
git push
```
The above commands push your code to the main branch.
However, we need to use the [ghp-import](https://github.com/c-w/ghp-import) package to push your website code to a separate branch.
To use the package, run the following to install it:
```sh
# For Mac and Linux users
pip install -U ghp-import

# For Windows users
conda install -c conda-forge ghp-import
```
Then, run the following command to push your html files to the `gh-pages` branch.
```sh
ghp-import -n -p -f _build/html
```

After this, go to the URL that points to your GitHub repository, click "Settings" -> "Pages" to go to the page settings.
You should see a message similar to "Your site is live at [XXX]", where "[XXX]" is your website URL that is publicly accessible, as shown below:

![github_page_url](images/github_page_url.png)

Also, sometimes it will take a while for GitHub to update your webpage content.
You can check the "Actions" page to check the status.
For example, here is the [Actions page for our tutorial repository](https://github.com/yenchiah/jupyter-book-template/actions).

You now have the public URL for your website.
More information about how to publish your book can be found on [this documentation](https://jupyterbook.org/en/stable/start/publish.html).

## Update the website content
<a name="update"></a>

After completing all the above steps, you should now have a remote repository on GitHub and a local repository on your computer.
Your local repository should be a folder with the name that we asked you to rename (i.e., the `MY_REPOSITORY_NAME` in the previous steps).
If you are still confused about why there are remote and local repositories, check the 15-minute Git tutorial video that is mentioned in the [Prerequisites](#pre).

If you cannot find the location of the folder on your computer, find it using the search functionality on your computer's operating system.
Use your repository name as the search keyword.
For Windows users, there should be a search bar near the Windows start menu.
For Mac users, there should be a magnifying glass icon at the top right.

Now you can start to work on your notebook or markdown files.
We recommend that you start with the `notebook.ipynb` file and replace the content with your code and text.
If you already have an existing notebook, you can replace the original `notebook.ipynb` file with your notebook and rename the file with `notebook.ipynb`.

To update the content of your website, **repeat step 4 and 5 without the package installation parts**.
Step 4 will rebuild the book, which means compiling/translating the notebook and markdown files into HTML/CSS/JavaScript files.
Step 5 will push your new content to the GitHub repository and update the online content of your website.
We provide the example terminal commands below:
```sh
jupyter-book build --all .
git status
git add .
git status
git commit -m "Update my book."
git push
ghp-import -n -p -f _build/html
```

You can also run the bash script:
```sh
./build_book.sh
```

Every time you build some new files (or updated files), you need to rebuild the book and push new changes to your remote GitHub repository.
This, again, will take some time for GitHub to process the changes and update the website.
You can check the Actions page (as shown in the image below) for the status.