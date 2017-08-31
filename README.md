
<!--[![Travis-CI Build Status](https://travis-ci.org/SMAC-Group/ds.svg?branch=master)](https://travis-ci.org/SMAC-Group/ds)-->
An Introduction to Statistical Programming Methods with R
=========================================================

<center>
Matthew Beckman, Stéphane Guerrier, Justin Lee & Roberto Molinari
</center>
Introduction
------------

This book is currently under development and has been designed as a support for students who are following (or are interested in) courses that provide the basic knowledge to master "statistical programming" with R. By the latter we mean that area of computer programming which focuses on the implementation of methods that not only manage data but also extract meaningful information from it. The importance of this area of research comes from the increased collection of data from different sources such as academic research, public institutions and private companies that has required a corresponding increase in data management and analysis tools. Consequently, the need to develop applications and methods that are able to deliver these tools has led to a surge in the demand for expertise not only in computer programming but also in statistical and numerical analysis. Indeed, while it is essential to master the basics of programming to build the necessary software, it is now also paramount to understand the programming tools that can effectively respond to the need of finding, extracting, and analyzing the information to achieve the required goals.

Within the above framework, the statistical software `R` has seen a rise in use due to its flexibility as an efficient language that builds a bridge between software development and data analysis. There are of course many other programming languages that have different advantages over `R` but, as you will see, one strength of `R` is the facility to develop and quickly adapt to the different needs coming from the data management and analysis community while at the same time making use of other languages in order to deliver computationally efficient solutions (as well as other interesting features described below). This book intends to present the basic tools to statistical programming and software development using the wide variety of tools made available through `R`, from method-specific packages to version control programs. The general goals of the book are therefore the following:

-   understand data structures in order to appropriately manage data, computer memory and computations;
-   manipulate data structures through controls, instructions, and tailored functions in order to achieve a desired output;
-   create new software tools (packages and web applications) that accommodate a previously unmet need;
-   learn how to manage software development via version control tools (e.g., GitHub) and create documentation for this software (with embedded code) to allow others to make use of the software.

All these goals are common to any basic programming course, however all these will be heavily focused on the use and development of statistical tools. In fact, as highlighted earlier, it has become increasingly important to include statistical methodologies within the programming framework thereby allowing software to not only manage data efficiently but also to extract and analyse data in an appropriate manner while doing so. The rest of this introductory chapter will present the R software by explaining why it is used for this book and describing the basic notations and tools that need to be known in order to better grasp its contents.

This document is **under development** and it is therefore preferable to always access the text online to be sure you are using the most up-to-date version. Due to its current development, you may encounter errors ranging from broken code to typos or poorly explained topics. If you do, please let us know! Simply add an issue to the GitHub repository used for this document (which can be accessed here <https://github.com/SMAC-Group/ds/issues>) and we will make the changes as soon as possible. In addition, if you know RMarkdown and are familiar with GitHub, make a pull request and fix an issue yourself, otherwise, if you're not familiar with these tools, they will be explained later on in the book itself.

<center>
![Note that this diagram is a adapted version of Figure 1 of <http://r4ds.had.co.nz/explore-intro.html>](images/diagram.png)
</center>
To demonstrate our goals, we will try to implement the process that is mentioned in the diagram above. Most cases, there is input that an audience provides, in which we then process and manipulate in R. Exploratory data analysis is performed using R, R Markdown, and Shiny applications as we preprocess, visualize, and model our data/input. We then communicate our results through websites, rapports, slides, we can use a narrative report using R Markdown with R as the backend. To communicate through a website, we can output interactive Shiny applications that take in multiple parameters and options. We can even use both. Some cases, after we communicate, we may find something new, and move back to the exploring stage.

`R` and `RStudio`
-----------------

The statistical computing language `R` has become commonplace for many applications in industry, government, and academia. Having started as an open-source language to make available different statistics and analytical tools to researchers and the public, it steadily developed into one of the major software languages which not only allows to develop up-to-date, sound, and flexible analytical tools, but also to include these tools within a framework which is well-integrated with other important programming languages, communication, and version-control features. The latter is also possible thanks to the development of the `RStudio` interface which provides a pleasant and functional user-interface for `R` as well as an efficient Integrated Development Environment (IDE) in which different programming languages, web-applications and other important tools are available to the user. In order to illustrate the relationship between R & RStudio in statistical programming, one might think of a car analogy in which R would be like the engine and RStudio might be like leather seats. R is doing the work (for the most part), and RStudio generally is making you more comfortable while you use R.
