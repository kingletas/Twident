using Gtk;

public class StatusBox : TextView {
	
	private Window parent;
	private MenuIndicator indicator;
	private Accounts accounts;
	public VBox vbox;
	private StatusChooseBar acc_box;
	
	private string reply_id = "";
	
	private int statuses_queue = 0;
	
	public StatusBox(Window parent, Accounts accounts) {
		this.parent = parent;
		this.indicator = ((MainWindow) parent).indicator;
		this.accounts = accounts;
		
		accounts.status_sent.connect((account, ok, msg) => {
			statuses_queue -= 1;
			
			if(statuses_queue < 1) {
				indicator.hide_queue();
				vbox.set_sensitive(true);
				buffer.text = "";
			}
			
			debug("the end of status sending");
			//TODO
		});
		
		accounts.do_reply.connect(reply);
		
		wrap_mode = WrapMode.WORD_CHAR;
		
		vbox = new VBox(false, 0);
		
		Frame frame = new Frame(null);
		frame.add(this);
		
		acc_box = new StatusChooseBar(accounts);
		
		vbox.pack_start(frame, true, true, 0);
		vbox.pack_start(acc_box, false, false, 0);
		
		this.buffer.changed.connect(text_changed);
		this.key_press_event.connect(actions);
	}
	
	private void text_changed() {
		int length = (int) buffer.text.len();
		acc_box.set_count(140 - length);
	}
	
	private bool actions(Gdk.EventKey event) {
		switch(event.hardware_keycode) {
		case 36: //return key
			if(event.state == 1) { //shift + enter
				buffer.insert_at_cursor("\n", (int)"\n".length);
				return true;
			}
			if(buffer.text.length > 0) {
				enter_pressed();
			} else { // if nothing to send
				var message_dialog = new MessageDialog(parent,
				Gtk.DialogFlags.DESTROY_WITH_PARENT | Gtk.DialogFlags.MODAL,
				Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
				(_("Type something first")));
				
				message_dialog.run();
				message_dialog.destroy();
			}
			return true;
		
		case 9: //esc key
			//clear();
			hide();
			break;
		}
		
		return false;
	}
	
	private void reply(AAccount account, Status status) {
		debug("reply");
		acc_box.unselect_all();
		acc_box.select(account);
		
		reply_id = status.id;
		buffer.text = "@%s ".printf(status.user.name);
		
		parent.set_focus(this);
	}
	
	private void enter_pressed() {
		debug("enter");
		
		if(settings.selected_for_posting.size < 1) {
			Gtk.MessageDialog dlg = new Gtk.MessageDialog(parent, Gtk.DialogFlags.MODAL,
				Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
				_("You need to choose some accounts for sending statuses"));
			
			dlg.run();
			dlg.close();
			
			return;
		}
		
		vbox.set_sensitive(false);
		
		statuses_queue = settings.selected_for_posting.size;
		indicator.add_queue(_("Sending statuses: %d").printf(statuses_queue));
		
		foreach(string hash in settings.selected_for_posting) {
			AAccount? account = accounts.get_by_hash(hash);
			
			if(account == null)
				continue;
			
			account.send_status(buffer.text, reply_id);
		}
		
		reply_id = "";
	}
}
