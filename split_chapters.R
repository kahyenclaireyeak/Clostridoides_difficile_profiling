# Read the content of the Markdown file
content <- readLines("CDI_overview.md")

# Identify the lines that start new top-level chapters (those starting with "# ")
chapter_starts <- grep("^# ", content)

# Check if any chapters were found
if (length(chapter_starts) == 0) {
  stop("No chapter headings found. Check your Markdown file to ensure chapters start with '# '.")
}

# Loop through each top-level chapter and write to a separate .qmd file
for (i in seq_along(chapter_starts)) {
  start_line <- chapter_starts[i]
  end_line <- ifelse(i < length(chapter_starts), chapter_starts[i + 1] - 1, length(content))
  
  # Extract chapter content, including all subsections until the next top-level section
  chapter_content <- content[start_line:end_line]
  
  # Create filename (index.qmd for the first chapter, chapter_2.qmd, etc.)
  chapter_name <- if (i == 1) "index.qmd" else paste0("chapter_", i, ".qmd")
  
  # Write content to .qmd file
  writeLines(chapter_content, chapter_name)
}

