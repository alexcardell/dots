local M = {}

M.setup = function()
  require('other-nvim').setup({
    mappings = {
      -- sbt src -> test
      {
        pattern = "/src/main/scala/(.*)/(.*).scala",
        target = "/src/test/scala/%1/%2Test.scala",
        context = "test"
      },
      -- sbt src -> it:test
      {
        pattern = "/src/main/scala/(.*)/(.*).scala",
        target = "/src/it/scala/%1/%2Test.scala",
        context = "it-test"
      },
      -- sbt test -> src
      {
        pattern = "/src/test/scala/(.*)/(.*)Test.scala",
        target = "/src/main/scala/%1/%2.scala",
        context = "main"
      },
      -- sbt it:test -> src
      {
        pattern = "/src/it/scala/(.*)/(.*)Test.scala",
        target = "/src/main/scala/%1/%2.scala",
        context = "main"
      },
      -- mill src -> test
      {
        pattern = "/src/(.*)/(.*).scala",
        target = "/test/src/%1/%2Test.scala",
        context = "test"
      },
      -- mill src -> it:test
      {
        pattern = "/src/(.*)/(.*).scala",
        target = "/it/src/%1/%2Test.scala",
        context = "test"
      },
      -- mill test -> src
      {
        pattern = "/test/src/(.*)/(.*)Test.scala",
        target = "/src/%1/%2.scala",
        context = "main"
      },
      -- mill it:test -> src
      {
        pattern = "/it/src/(.*)/(.*)Test.scala",
        target = "/src/%1/%2.scala",
        context = "main"
      },
    },
  })
end

return M
