# RISE Analysis in R

<img src="https://github.com/lumenlearning/rise/blob/master/rise.png" align="right" />

This R package helps you conduct RISE analyses as described in the paper *Bodily, R., Nyland, R., & Wiley, D. (2017). The RISE Framework: Using Learning Analytics to Automatically Identify Open Educational Resources for Continuous Improvement. International Review of Research on Distance and Open Learning, 18(2).* DOI: http://www.irrodl.org/index.php/irrodl/article/view/2952.

The purpose of a RISE analysis is to help an instructional designer / learning scientist / course developer / instructor quickly identify portions of a course that aren't supporting learning as effectively as they would like. When course materials are licensed as [open educational resources](http://opencontent.org/definition/), materials identified through RISE analysis can be iteratively enhanced through a process of continuous improvement. Special attention should be given to outcomes classified in quadrant four (at the bottom right), where students are spending more time than average using resources but performing below average on associated assessments. For more detail, please refer to the article.

Before a RISE analysis can be performed, a course must have:

  * clearly defined learning outcomes,
  * each piece of content (text, video, interactive, etc.) aligned to an outcome,
  * each individual assessment item aligned to an outcome, and
  * data about content use and assessment performance by outcome.  

## Installation

You can always install the latest version of the RISE Analysis package using:

``` r
install.packages("devtools")
devtools::install_github('lumenlearning/rise')
```

You will soon be able to install the released version of rise from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rise")
```

## Example

The rise package expects a data frame containing three columns:

* outcome name
* average score on all assessments aligned with the outcome
* average views of each learning resource aligned with the outcome

The package expects these columns in this order. Pre-process your data in order to conform to this format and you're ready to perform the RISE analysis.

The following example contains a toy data set so you can explore the features of the package.

``` r
library(rise)

# Create sample data
set.seed(12345)

# Sample outcomes licensed CC BY from https://courses.lumenlearning.com/wmopen-nmbiology1/chapter/learning-outcomes/
outcomes <- c("List the defining characteristics of biological life",
"Describe classification and organizational tools biologists use, including modern taxonomy",
"Identify the main branches of biology",
"Describe biology as a science and identify the key components of scientific inquiry",
"Define atoms and elements",
"Classify different types of atomic bonds",
"Demonstrate familiarity with the pH scale")

# Sample scores
avg_scores <- runif(7, min=50, max=100)

# Sample views
avg_views <- runif(7, min=0.5, max=1.5)

sample_df <- data.frame(outcomes, avg_scores, avg_views)

rise_df <- rise_analysis(sample_df)
rise_graphic <- rise_analysis(sample_df, visual = TRUE)
```

## License

The rise package is licensed under an MIT license. See the LICENSE and LICENSE.md files for additional details.

[![DOI](https://zenodo.org/badge/141607792.svg)](https://zenodo.org/badge/latestdoi/141607792)