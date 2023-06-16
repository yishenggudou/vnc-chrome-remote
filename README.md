# Google Chrome via VNC and Remote Debug

## Usage

### build docker images

edit `Makefile` and change `BASE_IMAGE_NAME` var 

then run

```bash
make build-image
```

### run local test

```bash
make test-run
```

### use via selenium

```python
from selenium import webdriver  
from selenium.webdriver.chrome.options import Options  
  
chrome_options = Options()  
chrome_options.add_experimental_option("debuggerAddress", "127.0.0.1:9223")  
driver = webdriver.Chrome(options=chrome_options)  
driver.get("http://www.baidu.com")
print(driver.title)
```

then you will see the vnc client 

![img.png](img.png)