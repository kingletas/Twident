/* config.vapi
 *
 * Copyright (C) 2009-2010  troorl
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author:
 * 	troorl <troorl@gmail.com>
 */

[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "config.h")]
namespace Config
{
	public const string APPNAME;
	public const string MENTIONS_PATH;
	public const string GROUP_PATH;
	public const string RT_PATH;
	public const string CONVERSATION_PATH;
	public const string SERVICE_TWITTER_ICON;
	public const string SERVICE_IDENTICA_ICON;
	public const string UPDATING_PATH;
	public const string RETWEET_PATH;
	public const string GETTEXT_PACKAGE;
	public const string LOCALEDIR;
}

[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "")]
namespace Soppa // Soppa is Swedish for Soup ;)
{
	[CCode (cname = "save_soup_data")]
	public bool save_soup_data(Soup.MessageBody data, string file);
}

[CCode (cheader_filename = "time_parser.h")]
namespace TimeParser {
	[CCode (cname = "time_to_diff")]
	public int time_to_diff(string datetime, bool atom);
}

/*
[CCode (cheader_filename = "sha1.h")]
namespace SHA1
{
  [CCode (cname = "_oauth_hmac_sha1")]
  public void hmac (string key, string message, out uchar[] output);
}
*/

/** My version of rest.vapi */
/* rest.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "", lower_case_cprefix = "rest_")]
namespace RestCustom {
	[CCode (cheader_filename = "rest/oauth-proxy.h")]
	public class OAuthProxy : Rest.Proxy {
		[CCode (cname = "oauth_proxy_new", type = "RestProxy*", has_construct_function = false)]
		public OAuthProxy (string consumer_key, string consumer_secret, string url_format, bool binding_required);

                [CCode (cname = "oauth_proxy_request_token_async")]
                public static bool request_token_async (OAuthProxy proxy, string function, string callback_uri, [CCode (delegate_target_pos = 4.9)] OAuthProxyAuthCallback callback, GLib.Object? weak_object) throws GLib.Error;

		[CCode (cname = "oauth_proxy_request_token")]
		public static bool request_token (OAuthProxy proxy, string function, string callback_uri) throws GLib.Error;

                [CCode (cname = "oauth_proxy_access_token_async")]
                public static bool access_token_async (OAuthProxy proxy, string function, string callback_uri, [CCode (delegate_target_pos = 4.9)] OAuthProxyAuthCallback callback, GLib.Object? weak_object) throws GLib.Error;

		[CCode (cname = "oauth_proxy_access_token")]
		public static bool access_token (OAuthProxy proxy, string url_format, string oob) throws GLib.Error;
		
		[CCode (cname = "oauth_proxy_auth_step")]
		public static bool auth_step (OAuthProxy proxy, string function) throws GLib.Error;
		[CCode (cname = "oauth_proxy_auth_step_async")]
		public static bool auth_step_async (OAuthProxy proxy, string function, Rest.OAuthProxyAuthCallback callback, GLib.Object weak_object) throws GLib.Error;
		[CCode (cname = "oauth_proxy_get_token")]
		public static unowned string get_token (OAuthProxy proxy);
		[CCode (cname = "oauth_proxy_get_token_secret")]
		public static unowned string get_token_secret (OAuthProxy proxy);
		[CCode (cname = "oauth_proxy_set_token")]
		public static void set_token (OAuthProxy proxy, string token);
		[CCode (cname = "oauth_proxy_set_token_secret")]
		public static void set_token_secret (OAuthProxy proxy, string token_secret);
		[CCode (cname = "oauth_proxy_new_with_token", type = "RestProxy*", has_construct_function = false)]
		public OAuthProxy.with_token (string consumer_key, string consumer_secret, string token, string token_secret, string url_format, bool binding_required);
		[NoAccessorMethod]
		public string consumer_key { owned get; construct; }
		[NoAccessorMethod]
		public string consumer_secret { owned get; construct; }
		public string token { get; set; }
		public string token_secret { get; set; }
	}

        [CCode (cheader_filename = "rest/oauth-proxy.h")]
        public delegate void OAuthProxyAuthCallback (OAuthProxy proxy, GLib.Error? error, GLib.Object? weak_object);
}
