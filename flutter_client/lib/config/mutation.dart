String createBlog = """
mutation CreateBlog(\$input: NewBlog!){
  createBlog(input: \$input){
    id,
    title,
    author,
    date,
    body,
  }
}
""";