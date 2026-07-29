# Termux-Desktop
<b>This will help you to setup a Graphical Environment in termux using XFCE.</b>
<b>Termux is an intractive application ion the android platform to run linux commands.</b>
</br></br>After setting up all these things , you will see something like this.

<a target="_blank" rel="noopener noreferrer" href="https://raw.githubusercontent.com/Juanoto2012/TermDesk/master/Images/Image-1.jpg"><img src="https://raw.githubusercontent.com/Juanoto2012/TermDesk/master/Images/Image-1.jpg" alt="Image-1" style="max-width:100%;"></a>
</br>
</br>
<a target="_blank" rel="noopener noreferrer" href="https://raw.githubusercontent.com/Juanoto2012/TermDesk/master/Images/Image-2.jpg"><img src="https://raw.githubusercontent.com/Juanoto2012/TermDesk/master/Images/Image-2.jpg" alt="Image-2" style="max-width:100%;"></a>

# Desktop Theme
This setup includes the **Fluent** GTK theme with **dark/light mode toggle**, **Mint-Y icon theme**, and **wallpapers** (wall 1 & wall 2).

## Theme Features
- **Fluent GTK theme** (light + dark variants)
- **Dark/Light mode toggle** — run `./theme.sh toggle` or use the interactive menu
- **Mint-Y icon theme**
- **Wallpapers** — wall-1.jpg (light mode) and wall-2.jpg (dark mode)

## Theme Commands
- `./theme.sh` — interactive menu for theme setup
- `./theme.sh full` — install everything (Fluent theme, icons, wallpapers, apply light theme)
- `./theme.sh light` — apply Fluent light theme with wall 1
- `./theme.sh dark` — apply Fluent dark theme with wall 2
- `./theme.sh toggle` — switch between dark and light mode
- `./theme.sh install-fluent [light|dark]` — install Fluent theme variant
- `./theme.sh install-icons` — install mint-y-icon-theme
- `./theme.sh wallpapers` — copy wallpapers to the wallpapers directory

## How to Install
- <code>apt update</code>
- <code>apt install git -y</code>
- <code>git clone https://github.com/Juanoto2012/TermDesk.git</code>
- <code>cd TermDesk</code>
- <code>chmod +x gui.sh theme.sh</code>
- <code>./gui.sh</code>

## Single Command Installation
<pre><code>apt update && apt install git -y && git clone https://github.com/Juanoto2012/TermDesk && cd TermDesk && chmod +x gui.sh theme.sh && ./gui.sh</code></pre>

## How to Start Termux Desktop Mode
<ol>
<li>Run <code>Xvfb :1 -screen 0 1080x1920x24 &amp;</code> to start the X11 virtual display.</li>
<li>Run <code>export DISPLAY=:1</code> to set the display environment variable.</li>
<li>Run <code>startxfce4 &amp;</code> to start the XFCE desktop.</li>
<li>Firefox is pre-installed — open it from the XFCE menu to browse the web.</li>
<li>X11 provides hardware acceleration and better performance compared to VNC.</li>
</ol>

## Exit from Termux GUI
<pre>pkill Xvfb
</pre>
<b>This kills the X11 virtual display and closes the desktop session</b>

## Changing Theme After Setup
Once the desktop is running, you can change the theme at any time:
<pre><code>./theme.sh toggle    # switch between dark and light</code></pre>

## Exit from Termux GUI
<pre>pkill Xvfb
</pre>
<b>This kills the X11 virtual display and closes the desktop session</b>
</br>
# Follow me on 
<a href="https://github.com/techpanther22"><img src="https://camo.githubusercontent.com/6db5a07d93819ee616798a5448d0b1c1746f6b45/68747470733a2f2f6564656e742e6769746875622e696f2f537570657254696e7949636f6e732f696d616765732f706e672f6769746875622e706e67" alt="Github" width="50px"></a>
<a href="https://www.instagram.com/techpanther22/"><img src="https://camo.githubusercontent.com/68ff38b86f01b428567dcc406116e23728245f4e/68747470733a2f2f6564656e742e6769746875622e696f2f537570657254696e7949636f6e732f696d616765732f7376672f696e7374616772616d2e737667" alt="Instagram" width="50px"></a>
<a href="https://www.youtube.com/techpanther"><img src="https://camo.githubusercontent.com/0f31a4f7adb78461ca03dfaad4a138eedf0d14e0/68747470733a2f2f6564656e742e6769746875622e696f2f537570657254696e7949636f6e732f696d616765732f7376672f696e7374616772616d2e737667" alt="Youtube" width="50px"></a>
<a href="https://www.facebook.com/techpanther22"><img src="https://camo.githubusercontent.com/e6d2040c65e8c6f4da10db72436cf9a1196e43ae/68747470733a2f2f6564656e742e6769746875622e696f2f537570657254696e7949636f6e732f696d616765732f7376672f66616365626f6f6b2e737667" alt="Facebook" width="50px"></a>
<a href="https://techpanther.in"><img src="https://camo.githubusercontent.com/f04204907e15a5b57cacd62b46bd7eaddf481713/68747470733a2f2f6564656e742e6769746875622e696f2f537570657254696e7949636f6e732f696d616765732f7376672f626c6f676765722e737667" alt="Webbsite" width="50px"></a>
