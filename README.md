
# Computrace-Mitigator
Stuff to help block Computrace via software tweaks  
  
## What is Computrace?
Computrace an motherboard option in some computer BIO's which allows a company called "*Absolute*" to track your computer and has the ability to remotely brick it at the whim of the original owner or company.  
*Absolute* also has communications to authorities.  
It's intended as an anti theft and works like a root kit, but because it cannot be turned off once activated. It makes buying used computers or trash picked computers an absolute pain in the butt.  
![RIP](https://i.imgur.com/DlXiBaT.png)  
If you see this screen, it's enabled.  
  
Also anti viruses completely whitelist computrace and from what I've read, malware loves to abuse computrace to spread.  
Which is interesting as the computer I trash picked turned out to be completely infected by MERIN ransomware. I wonder if it's related, but either way I'm blamming Computrace for it and I'm assuming the ransomware infection was why this Lenovo Thinkcentre I got was thrown in the dump.  

## Huh? How does it work?
Once enabled, instead of booting up your PC via the usual process:  
1. BIOS screen  
2. BIOS->Windows Boot Manager EFI  
  
It'll run in this sequence instead:  
1. BIOS screen  
2. BIOS->Computrace  
3. BIOS->Windows Boot Manager EFI  

Since there's two "Computrace" programs to explain, I'll refer to them as **BIOS_Computrace** and **WINDOWS_Computrace**.  
  
Anyway, once enabled every time the computer is turned on, the **BIOS_Computrace** subroutine will start.  
  
It can read FAT32 and NTFS drives and scans all partitions until it finds:  
**:\Windows\Autochk.exe**  
Which it will patch with it's own sketchy program.  
**BIOS_Computrace** in itself cannot connect to the internet on it's own or anything, or actually communicate to *Absolute* in anyway.  
After Autochk.exe is patched, **BIOS_Computrace** will then start Windows next.  

During the Windows boot process, it  will run the modified Autochk.exe immediately.  
It then extracts a bunch of executables and stuff to **:\Windows\System32** and **:\Windows\SysWOW64**. Then modifies the registry to run the executables on startup as a service. **rpcnet.exe** and **rpcnetp.exe** appear to be the main ones in particular.  
![Bunch of files extracted](https://i.imgur.com/BfmyFHc.png)

Once Windows is on the desktop, it would have already started these **rpcnet** services which I'm going to call **Windows_Computrace**.  

Letting **Windows_Computrace** start while having internet access is very *very* bad, as you're basically giving *Absolute* full access to your entire machine remotely, kinda like a RAT but is whitelisted and legal for some reason.  
If the motherboard is equipped with GPS hardware, *Absolute* can take that info, along with your files and IP address and give it out to authorities if they wanted to.  

Here's an image I found from reddit from a guy that bought a used laptop on ebay, only for the owner to lock it out using Computrace.  
![Computrace Takeover](https://cdn.discordapp.com/attachments/375192450827812864/1047918159354679438/unknown.png)

Check out the **PDF's** folder included in this package for some real nerdy details.  

## WTF? How can I disable it
You can't once it's enabled on there, it's stuck there unless you wanna deal with Computrace customer support. But there's some ways to mitigate it.  
First off you can see whether it has injected into your windows install by going to task manager and looking for any rpcnet  processes. If so, you can run the included **Temporary Kill.bat** file as administrator which will remove all currently known Computrace files out of Windows. But keep in mind they will reappear on the next reboot.  

### 1. Simple host file block
While this method doesn't stop the program from running, it stops the rpcnet processes from actually talking to *Absolute*.  
Run notepad as administator and edit **C:\Windows\System32\drivers\etc\hosts**
Copy all the listings in the included **Hosts File Entries.txt** file and paste it on the bottom of the file like so:  
![Hosts Block](https://i.imgur.com/qZocvRM.png)  
This will basically point all absolute servers to yourself, effectively blocking it.  
  
  
### 2. Image File Execution using debug flags
There's an awesome option in the registry called "Image File Execution Options". There's a setting you can create called **Debugger**, and using this you can actually redirect one .exe with a specific filename to actually run another program instead.  
I used to use this method back in the day to make Ease of Access on Windows 7 run CMD instead on my school laptop. So if my account was locked out I could always get back in.  

Anyway included in the package is **Image File Execution Block.reg**. Installing this will prevent the **Windows_Computrace** / **rpcnet** services from starting up if it ever got the chance.  
![Image FIle Execution Options FTW](https://i.imgur.com/sJBBYGx.png)

### 3. Use Linux
Supposedly Computrace doesn't support linux at all due to the way it works.  
So in theory just using Linux instead should keep you save? I haven't tested this method but it seems like an extreme one to change your entire preferred OS.  

### 4. Reflashing the BIOS with a generic one that doesn't contain Computrace
From what I understand, no matter what bios ROM you flash onto the motherboard from the manufacturer, Computrace seems to live.  

However if you were to reflash the entire bios EPROM with a generic one like https://libreboot.org that doesn't even contain Computrace anyway, you should be gold.  
But it requires a lot technical knowledge, flashing tools and patience.  
Heck there's a good chance you'll end up with a brick if it's not compatible with your board or BIOS. If you don't value your time or resources, but have the skill then this could be a fun project.  
Here's a video by [Mental Outlaw](https://www.youtube.com/@MentalOutlaw) installing it to a Thinkpad: https://www.youtube.com/watch?v=WyItt8FJWIs  

And here's a video of [TheOmnitubers](https://www.youtube.com/@TheOmnitubers) reflashing it via a common raspberry pi:  
https://www.youtube.com/watch?v=VFPT3e6obiI  

## What didn't work

Surprisingly bitlocker encryption doesn't prevent Computrace from being installed, initially I thought it did but it took another reboot.  
I also found a feature in Windows called WPBT which allows hardware vendors to easily install any junk into the Windows Installation including other theft tracking executables.  
There is another project for disabling WPBT entirely, but I tested bitlocker with the regedit key and it didn't seem to have any effect on Computrace. I'm still trying other options though.  
https://github.com/Jamesits/dropWPBT

For me though for personal use,  I'm going to combine methods 1-2 together but I still feel it's not enough. Call me paranoid if you want. But I just wanna watch garfield on my TV from a trash picked computer without having to worry about a swat team showing up at my house.