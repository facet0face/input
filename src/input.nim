import winim/lean, bitops

const input_size = int32 sizeof INPUT

func held*(key: int32): bool =
    GetAsyncKeyState(SHORT key) != 0

func press*(key: int32) =
    var input: INPUT
    let scan = MapVirtualKey(key, 0)
    input.type = INPUT_KEYBOARD
    input.union1.ki.wVk = WORD key
    input.union1.ki.wScan = WORD scan
    SendInput(1, addr input, input_size)
    input.union1.ki.dwFlags = KEYEVENTF_KEYUP
    SendInput(1, addr input, input_size)

func click*() =
    var input: INPUT
    input.type = INPUT_MOUSE
    input.union1.mi.dwFlags = MOUSEEVENTF_LEFTDOWN
    SendInput(1, addr input, input_size)
    input.union1.mi.dwFlags = MOUSEEVENTF_LEFTUP
    SendInput(1, addr input, input_size)

func move*(x: int16, y: int16) =
    var input: INPUT
    input.type = INPUT_MOUSE
    input.union1.mi.dwFlags = bitor(MOUSEEVENTF_ABSOLUTE, MOUSEEVENTF_MOVE)
    input.union1.mi.mouseData = 0
    input.union1.mi.dx = x
    input.union1.mi.dy = y
    SendInput(1, addr input, input_size)

func get_mouse_pos*(): POINT =
    GetCursorPos result
    result