stackr: an R package for connecting to the Stack Exchange API
----------------------------

This R package serves as an unofficial wrapper for the read-only features of the [Stack Exchange API](https://api.stackexchange.com/) with the ability to download information on questions, answers, users, tags, and other aspects of the site so that they can be analyzed in R. It is *not* affiliated with Stack Exchange.

The [documentation](https://api.stackexchange.com/docs/) of the Stack Exchange API is worth reviewing, as the package is built to resemble that interface while remaining true to R's style and syntax.

## Installation

You can install the package with [devtools](https://github.com/hadley/devtools) as such: 

```{r}
# install.packages("devtools")
devtools::install_github("dgrtwo/stackr")

# if you want to access the vignettes from within the package:
devtools::install_github("dgrtwo/stackr", build_vignettes = TRUE)
browseVignettes("stackr")
```

## Basics

Methods for querying objects from the APIare implemented in functions of the form `stack_[object]`. Each of these functions returns a data frame, with one row per object.

For example, one could query recent questions with:


```r
q <- stack_questions()
```

And recent answers with:

```r
a <- stack_answers()
```

Almost all of these functions can take as their first argument one or more IDs. For example, one could query a specific question:

```r
stack_questions(11227809)
```

Or one could query multiple answers using a vector:

```r
stack_answers(c(179147, 2219560, 180085))
```

Other results you can query include users:

```r
stack_users(712603)
```

Or tags, which are queried by name instead of id:


```r
stack_tags(c("r", "ggplot2", "dplyr"))
```

## Returned values

Each of these functions returns a `data.frame`. The columns that are included depend on the object being returned, with documentation available on the Stack Exchange API site:

* [answer](https://api.stackexchange.com/docs/types/answer)
* [badge](https://api.stackexchange.com/docs/types/badge)
* [comment](https://api.stackexchange.com/docs/types/comment)
* [info](https://api.stackexchange.com/docs/types/info)
* [post](https://api.stackexchange.com/docs/types/post)
* [privilege](https://api.stackexchange.com/docs/types/privilege)
* [question](https://api.stackexchange.com/docs/types/question)
* [revision](https://api.stackexchange.com/docs/types/revision)
* [suggested-edit](https://api.stackexchange.com/docs/types/suggested-edit)
* [tags](https://api.stackexchange.com/docs/types/tags)
* [user](https://api.stackexchange.com/docs/types/user)

## Special queries

A function like `stack_questions` does not *necessarily* return questions. By providing a second argument to the query, one can extract objects that are related to that object. For example, one could extract all the answers to a particular question with:

```r
answers <- stack_questions(11227809, "answers")
```

Similarly, one could extract the comments, linked questions, or related questions with:


```r
comments <- stack_questions(11227809, "comments")
linked <- stack_questions(11227809, "linked")
related <- stack_questions(11227809, "related")
```

There are many other combinations: one could extract a user's comments:


```r
my_comments <- stack_users(712603, "comments")
```

The combinations of methods and actions is best explained in the [documentation](https://api.stackexchange.com/docs/).

## Pagination

You can set the `pagesize` argument to any method to determine the number of objects to be returned. However, the maximum value of this is 100, which means multiple requests must be made to download a list larger than 100.

`stackr` handles this pagination with the `num_pages` argument, which all methods accept. This gives a maximum number of pages (and therefore requests) that will be iterated through, combining them together at the end.

## API Key

It's a good idea to set up a registered API key with Stack Exchange, since it increases your daily quota of queries from 300 to 10,000. You can [register an app here](http://stackapps.com/apps/oauth/register). Once you have your Stack Exchange application key, set up an environment variable, by adding the following line to your `.Rprofile`:


```r
Sys.setenv(STACK_EXCHANGE_KEY = "YOUR_KEY_HERE")
```

After that, queries made from your system will use your key.

Future plans
-------------------

Currently, no methods requiring authentication are implemented. OAuth 2.0 could be implemented through the same httr framework ([see here](http://cran.r-project.org/web/packages/httr/vignettes/api-packages.html)), but my current judgment is that R is likely to be used for data analysis operations rather than actual front-ends for Stack Exchange, which negates the need for most authentication-based operations.

So far, no network methods (such as "/sites", or "/apps") have yet been implemented; only per-site methods.

Bug reports are very welcome [here](http://github.com/dgrtwo/stackr/issues).
