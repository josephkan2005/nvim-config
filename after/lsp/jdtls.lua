return {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-25',
            path = '/usr/lib/jvm/java-25-openjdk-amd64',
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
