package tinyfd

import "core:c"
import "core:testing"

when ODIN_OS == .Linux {
	foreign import lib "tinyfd-zig/zig-out/lib/libtinyfd.a"
} else when ODIN_OS == .Windows {
	foreign import lib "tinyfd-zig/zig-out/lib/tinyfd.lib"
} else when ODIN_OS == .Darwin {
	foreign import lib "tinyfd-zig/zig-out/lib/libtinyfd.a"
}

//Note the comments here are copied from the C header so is not directly translated to odin

@(default_calling_convention = "c", link_prefix = "tinyfd_")
foreign lib {
	beep :: proc() ---
	/*
		aTitle: NULL or ""
		aMessage: NULL or "" may contain \n \t
		aIconType: "info" "warning" "error"
	*/
	notifyPopup :: proc(aTitle: cstring, aMessage: cstring, aIconType: cstring) -> c.int ---
	/*
		aTitle: NULL or ""
		aMessage: NULL or "" may contain \n \t
		aDialogType: "ok" "okcancel" "yesno" "yesnocancel"
		aIconType: "info" "warning" "error" "question"
		aDefaultButton: 0 for cancel/no , 1 for ok/yes , 2 for no in yesnocancel
		returns: Button index
	*/
	messageBox :: proc(aTitle: cstring, aMessage: cstring, aDialogType: cstring, aIconType: cstring, aDefaultButton: c.int) -> c.int ---
	/*
		aTitle: NULL or ""
		aMessage: NULL or "" (\n and \t have no effect)
		aDefaultInput: NULL = passwordBox, "" = inputbox
		returns: NULL on cancel
	*/
	inputBox :: proc(aTitle: cstring, aMessage: cstring, aDefaultInput: cstring) -> cstring ---
	/*
		aTitle: NULL or ""
		aDefaultPathAndOrFile: NULL or "" , ends with / to set only a directory
		aNumOfFilterPatterns: 0  (1 in the following example)
		aFilterPatterns: NULL or char const * lFilterPatterns[1]={"*.txt"}
		aSingleFilterDescription: NULL or "text files"
		returns: NULL on cancel
	*/
	saveFileDialog :: proc(aTitle: cstring, aDefaultPathAndOrFile: cstring, aNumOfFilterPatterns: c.int, aFilterPatterns: [^]cstring, aSingleFilterDescription: cstring) -> cstring ---
	/*
		aTitle: NULL or ""
		aDefaultPathAndOrFile: NULL or "" , ends with / to set only a directory
		aNumOfFilterPatterns: 0 (2 in the following example)
		aFilterPatterns: NULL or char const * lFilterPatterns[2]={"*.png","*.jpg"};
		aSingleFilterDescription: NULL or "image files"
		aAllowMultipleSelects:  0 or 1
		returns: NULL on cancel. In case of multiple files, the separator is |
	*/
	openFileDialog :: proc(aTitle: cstring, aDefaultPathAndOrFile: cstring, aNumOfFilterPatterns: c.int, aFilterPatterns: [^]cstring, aSingleFilterDescription: cstring, aAllowMultipleSelects: c.int) -> cstring ---
	/*
		aTitle: NULL or ""
		aDefaultPath: NULL or ""
		returns: NULL on cancel
	*/
	selectFolderDialog :: proc(aTitle: cstring, aDefaultPath: cstring) -> cstring ---
	/*
		aTitle: NULL or ""
		aDefaultHexRGB: NULL or "" or "#FF0000"
		aDefaultRGB[3]: unsigned char lDefaultRGB[3] = { 0 , 128 , 255 };
		aoResultRGB[3]: unsigned char lResultRGB[3];

		aDefaultRGB is used only if aDefaultHexRGB is absent
		aDefaultRGB and aoResultRGB can be the same array
		returns NULL on cancel
		returns the hexcolor as a string "#FF0000"
		aoResultRGB also contains the result
	*/
	colorChooser :: proc(aTitle: cstring, aDefaultHexRGB: cstring, aDefaultRGB: [3]c.char, aoResultRGB: [3]c.char) -> cstring ---
}

@(test)
test_beep_with_popup :: proc(t: ^testing.T) {
	beep()
	notifyPopup("Hello, World", "This is a test!", "info")
}
