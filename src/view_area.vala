using Gtk;
using Gee;

public class ViewArea : VBox {
	
	private Accounts accounts;
	private HashMap<AStream, FeedView> map;
	private AStream current_stream;
	
	public ViewArea(Accounts accounts) {
		this.accounts = accounts;
		
		map = new HashMap<AStream, FeedView>();
		
		homogeneous = true;
		spacing = 0;
		
		accounts.insert_new_stream_after.connect((path, stream) => {
			FeedView view = create_feed_view(stream);
			view.show_all();
			set_current_view(stream);
		});
		
		accounts.element_was_removed.connect((path, account, stream) => {
			//if account
			if(stream == null) {
				foreach(AStream st in account.streams) {
					remove_feed_view(st);
					debug("streams removed");
				}
			} else { //if stream
				remove_feed_view(stream);
			}
		});
		
		accounts.insert_new_account.connect((account) => {
			foreach(AStream stream in account.streams) {
				create_feed_view(stream);
			}
		});
		
		//generate_views();
		//show_all();
	}
	
	public void generate_views() {
		foreach(AAccount account in accounts) {
			foreach(AStream stream in account.streams) {
				create_feed_view(stream);
			}
		}
	}
	
	private void remove_feed_view(AStream stream) {
		FeedView view = map[stream];
		remove(view);
		map.remove(stream);
		
		if(stream == current_stream)
			current_stream.dispose();
	}
	
	private FeedView create_feed_view(AStream stream) {
		FeedView view = new FeedView();
		
		view.set_model(stream.model);
		
		map[stream] = view;
		
		pack_start(view, true, true, 0);
		view.hide();
		
		return view;
	}
	
	public void set_current_view(AStream stream) {
		if(stream == current_stream)
			return;
		
		map[current_stream].hide();
		current_stream = stream;
		
		
		FeedView view = map[stream];
		view.show_all();
	}
}
