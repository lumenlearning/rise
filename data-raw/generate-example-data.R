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
