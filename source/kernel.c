#define VIDEO_MEMORY 0xb8000
#define FILL_SCREEN 0xFA0
#define TEXT_COLOR 0x09 /* blue */

void clear_screen();
void print(char *message);

void kernel_entry() 
{
	clear_screen();
	print("Hello, world!");
};

void clear_screen()
{
	char *video_memory = (char *) VIDEO_MEMORY;

	for(unsigned int i = 0; i < FILL_SCREEN; i++) {
		video_memory[i++] = ' ';
		video_memory[i] = TEXT_COLOR;

	}
};

void print(char *message)
{
	char *video_memory = (char *) VIDEO_MEMORY;
	unsigned int lines = 0;
	unsigned int i = 0;

	while (*message) {
		if (*message == '\n') {
			lines++;
			i = lines * 80 * 2;
		} else {
			video_memory[i++] = *message;
			video_memory[i++] = TEXT_COLOR;
		}
		message++;
	}

}
