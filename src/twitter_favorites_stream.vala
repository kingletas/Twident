using Gee;
using TwidentEnums;

namespace Twitter {

public class StreamFavorites : Twitter.StreamHome {

	public override StreamEnum stream_type {get { return StreamEnum.FAVORITES; } }
	
	private override string func {get; set; default = "favorites.xml";}
	
	public override string id {get; set; default = "favorites";}
	
	construct {
	}
}

}
