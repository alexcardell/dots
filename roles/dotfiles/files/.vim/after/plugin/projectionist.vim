" let g:projectionist_heuristics = {
"       \ "src/main/java": {
"       \   "src/main/java/*.java": {
"       \     "alternate": "src/test/java/{}(Spec|Test)?.java"
"       \   },
"       \   "src/test/java/*.java": {
"       \     "alternate": "src/main/java/{}(Spec|Test)?.java"
"       \   },
"       \ },
"       \ "src/main/scala": {
"       \   "src/main/scala/*.scala": {
"       \     "alternate": "src/test/scala/{}(Spec|Test)?.scala"
"       \   },
"       \   "src/test/scala/*.scala": {
"       \     "alternate": "src/main/scala/{}(Spec|Test)?.scala"
"       \   }
"       \ }}
