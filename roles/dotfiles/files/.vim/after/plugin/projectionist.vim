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

"""""""""""""
" Scala
"{
"  "src/main/scala/*.scala": {
"    "type": "source",
"    "alternate": "src/test/scala/{}Spec.scala"
"  },
"  "src/test/scala/*Spec.scala": {
"    "type": "test",
"    "alternate": "src/main/scala/{}.scala"
"  }
"}
