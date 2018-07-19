context("test-rise.R")

# Need to create more / more useful tests.

library(ggplot2)
p <- rise(sample_df)
q <- rise(sample_df, visual = TRUE)

test_that("Annotation happens...", {
  expect_equal(ncol(p), 5 )
})

test_that("RISE quadrant assignment happens correctly...", {
  expect_equal(is.numeric(p[,4]), TRUE )
})

test_that("RISE inside/outside assignment happens correctly...", {
  expect_equal(is.numeric(p[,5]), TRUE )
})

test_that("RISE graphic is created...", {
  expect_equal(is.ggplot(q), TRUE )
})
