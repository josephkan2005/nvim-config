return {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-25',
            path = '/usr/lib/jvm/java-25-openjdk-amd64',
            sources = '/usr/lib/jvm/java-25-openjdk-amd64/lib/src.zip',
            default = true,
          },
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      symbols = {
        includeSourceMethodDeclarations = true,
      },
    },
  },
}
