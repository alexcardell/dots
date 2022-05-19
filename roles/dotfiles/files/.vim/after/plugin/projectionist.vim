let g:projectionist_heuristics = {
      \ "build.sbt": {
      \   "src/main/scala/*.scala": {
      \     "type": "source",
      \     "alternate": "src/test/scala/{}Test.scala"
      \   },
      \   "src/test/scala/*Test.scala": {
      \     "type": "test",
      \     "alternate": "{}/src/main/scala/{}.scala"
      \   },
      \ },
      \ }
