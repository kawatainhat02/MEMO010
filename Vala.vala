int main () {
    print ("Hello World\n");
    
    return 0;
}

class Sample : Object {
    void greeting () {
        stdout.printf ("Hello World\n");
    }
    
    static void main (string[] args) {
        var sample = new Sample ();
        sample.greeting ();
    }
}

  using Gtk;
 
int main (string[] args) {
    Gtk.init (ref args);
    
    var window = new Window ();
    window.title = "Hello, World!";
    window.border_width = 10;
    window.window_position = WindowPosition.CENTER;
    window.set_default_size(350, 70);
    window.destroy.connect (Gtk.main_quit);
    
    var label = new Label ("Hello, World!");
    
    window.add (label);
    window.show_all ();
    
    Gtk.main ();
    return 0;
}
  
