function postCreate()
FlxG.state.forEachOfType(FlxText, text -> text.font = Paths.font("aumsum/comic.ttf");