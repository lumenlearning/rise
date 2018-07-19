# rise

This R package helps you conduct RISE analyses as described in the paper Bodily, R., Nyland, R., & Wiley, D. (2017). The RISE Framework: Using Learning Analytics to Automatically Identify Open Educational Resources for Continuous Improvement. International Review of Research on Distance and Open Learning, 18(2). DOI: http://www.irrodl.org/index.php/irrodl/article/view/2952.

## Installation

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

