*************************************************************
# Pre-field Process

## Installing Software and Defining an Area of Interest

Each line presented below is a separate line of code that should be run individually in Terminal. Wait for each process to complete before starting the next. The following installation process was tested on a clean installation of MacOS Big Sur 11.5.1 on August 1, 2021.

### Installation
Open the Terminal application on your MacOS device (Applications > Utilities > Terminal)

Install Homebrew (for more information: https://www.brew.sh) by entering the following line in Terminal and pressing 'Return.' Follow all prompts to enter your password.

```{r, engine = 'bash', eval = FALSE}
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Docker and then Docker Machine

```{r, engine = 'bash', eval = FALSE}
brew install docker docker-machine
```

Install Git, Python, and GDAL and other dependencies.

```{r, engine = 'bash', eval = FALSE}
brew install git python gdal proj libgit2 udunits
```

Install OpenDroneMap (although this tool is free and open-source, please consider contributing to the creators if you can! https://www.opendronemap.org)

```{r, engine = 'bash', eval = FALSE}
git clone https://github.com/OpenDroneMap/OpenDroneMap.git
```

Install R
```{r, engine = 'bash', eval = FALSE}
brew install r
```
