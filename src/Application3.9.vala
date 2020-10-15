/*
* Copyright (c) 2020 charalabos (charchatzo2008@gmail.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: charalabos <charchatzo2008@gmail.com>
*/
using Granite;
using Granite.Widgets;
using Gtk;
using WebKit;
namespace Dive {
    public class Application : Gtk.Application {

        public Application () {
            Object(
                application_id: "com.github.charchatzo.LinuxGameHub",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }



        public override void activate () {
            var builder = new Builder ();
            builder.add_from_file ("/usr/share/Main.glade");
            builder.connect_signals (null);
            var window = builder.get_object ("win") as Window;
            var winepath = builder.get_object ("winepath") as Entry;
            var wineplay = builder.get_object ("wineplay") as Button;
            var steamplay = builder.get_object ("steamplay") as Button;
            var settings = new GLib.Settings ("com.github.charchatzo.LinuxGameHub");
            var originplay = builder.get_object ("originplay") as Button;
            var originpath = builder.get_object ("originpath") as Entry;
            var legendarylaunch = builder.get_object ("legendarylaunch") as RadioButton;
            var legendaryplay = builder.get_object ("legendaryplay") as Button;
            var legendarygame = builder.get_object ("legendarygame") as Entry;
            var legendaryupdate = builder.get_object ("legendaryupdate") as RadioButton;
            var legendarylist = builder.get_object ("legendarylist") as RadioButton;
            winepath.placeholder_text = "Game Path Here";
            winepath.text = settings.get_string ("lastwinegame");
            originpath.text = settings.get_string ("lastoriginpath");
            legendaryplay.clicked.connect (() => {
                if (legendarylaunch.get_active() == true) {

                    string ls_stdout;
                    string ls_stderr;
                    int ls_status;

                    try {
                        Process.spawn_command_line_sync ("legendary launch " + legendarygame.text,
                                                    out ls_stdout,
                                                    out ls_stderr,
                                                    out ls_status);

                        // Output: <File list>
                        print ("stdout:\n");
                        // Output: ````
                        print (ls_stdout);
                        print ("stderr:\n");
                        print (ls_stderr);
                        // Output: ``0``
                        print ("Status: %d\n", ls_status);
                    } catch (SpawnError e) {
                        print ("Error: %s\n", e.message);
                    }
                }
                if (legendaryupdate.get_active() == true) {

                    string ls_stdout;
                    string ls_stderr;
                    int ls_status;

                    try {
                        Process.spawn_command_line_sync ("legendary update " + legendarygame.text,
                                                    out ls_stdout,
                                                    out ls_stderr,
                                                    out ls_status);

                        // Output: <File list>
                        print ("stdout:\n");
                        // Output: ````
                        print (ls_stdout);
                        print ("stderr:\n");
                        print (ls_stderr);
                        // Output: ``0``
                        print ("Status: %d\n", ls_status);
                    } catch (SpawnError e) {
                        print ("Error: %s\n", e.message);
                    }
                }
                if (legendarylist.get_active() == true) {

                    string ls_stdout;
                    string ls_stderr;
                    int ls_status;

                    try {
                        Process.spawn_command_line_sync ("legendary list-games " + legendarygame.text,
                                                    out ls_stdout,
                                                    out ls_stderr,
                                                    out ls_status);

                        // Output: <File list>
                        print ("stdout:\n");
                        // Output: ````
                        print (ls_stdout);
                        print ("stderr:\n");
                        print (ls_stderr);
                        // Output: ``0``
                        print ("Status: %d\n", ls_status);
                    } catch (SpawnError e) {
                        print ("Error: %s\n", e.message);
                    }
                }
            });

            originplay.clicked.connect (() => {
                settings.set_string ("lastoriginpath", originpath.get_text ());
                string ls_stdout;
                string ls_stderr;
                int ls_status;

                try {
                    Process.spawn_command_line_sync ("wine " + "'" + originpath.text + "'",
                                                out ls_stdout,
                                                out ls_stderr,
                                                out ls_status);

                    // Output: <File list>
                    print ("stdout:\n");
                    // Output: ````
                    print (ls_stdout);
                    print ("stderr:\n");
                    print (ls_stderr);
                    // Output: ``0``
                    print ("Status: %d\n", ls_status);
                } catch (SpawnError e) {
                    print ("Error: %s\n", e.message);
                }
            });
            steamplay.clicked.connect (() => {

                string ls_stdout;
                string ls_stderr;
                int ls_status;

                try {
                    Process.spawn_command_line_sync ("steam",
                                                out ls_stdout,
                                                out ls_stderr,
                                                out ls_status);

                    // Output: <File list>
                    print ("stdout:\n");
                    // Output: ````
                    print (ls_stdout);
                    print ("stderr:\n");
                    print (ls_stderr);
                    // Output: ``0``
                    print ("Status: %d\n", ls_status);
                } catch (SpawnError e) {
                    print ("Error: %s\n", e.message);
                }
            });
            wineplay.clicked.connect (() => {
                settings.set_string ("lastwinegame", winepath.get_text ());
                string ls_stdout;
                string ls_stderr;
                int ls_status;

                try {
                    Process.spawn_command_line_sync ("wine " + "'" + winepath.text + "'",
                                                out ls_stdout,
                                                out ls_stderr,
                                                out ls_status);

                    // Output: <File list>
                    print ("stdout:\n");
                    // Output: ````
                    print (ls_stdout);
                    print ("stderr:\n");
                    print (ls_stderr);
                    // Output: ``0``
                    print ("Status: %d\n", ls_status);
                } catch (SpawnError e) {
                    print ("Error: %s\n", e.message);
                }
            });
            

            window.show_all ();
            Gtk.main ();
        }

        public static int main (string[] args) {
            var app = new Dive.Application ();
            return app.run (args);
        }
    }
}
