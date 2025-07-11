// Import the Wacl library
import { Wacl } from './wacl.mjs';

// 1. Initialize the Xterm.js Terminal
const term = new Terminal({
  cursorBlink: true,
  convertEol: true // Automatically handle line endings
});
term.open(document.getElementById('terminal'));
term.write('Loading Tcl environment...\r\n');

// 2. Create a new Wacl (Tcl) instance
const tcl = await Wacl.create({
    // Redirect Tcl's output to the Xterm.js terminal
    stdout: (str) => term.write(str),
    stderr: (str) => term.write(`\x1b[31m${str}\x1b[0m`), // Write errors in red
});

term.write('Tcl is ready. Loading your app...\r\n');

// 3. Load and run your Tcl script
try {
    const response = await fetch('./GramaCuerda/cli.tcl'); // Fetch your app's code
    const tclCode = await response.text();
    await tcl.eval(tclCode); // Execute the entire script
    term.write('App loaded. You can now interact with it.\r\n');
    term.prompt = () => {
        term.write('$ ');
    };
    term.prompt();
} catch (error) {
    term.write(`Error loading Tcl script: ${error}`);
}


// 4. Handle user input from the terminal
let command = '';
term.onData(e => {
  switch (e) {
    case '\r': // Enter
      term.write('\r\n');
      if (command) {
        tcl.eval(command).catch(err => term.write(`\x1b[31m${err}\x1b[0m\r\n`));
        command = '';
      }
      term.prompt();
      break;
    case '\u007F': // Backspace
      if (term.buffer.active.cursorX > 2) {
        term.write('\b \b');
        command = command.slice(0, command.length - 1);
      }
      break;
    default: // Any other character
      command += e;
      term.write(e);
  }
});