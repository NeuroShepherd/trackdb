
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def dismiss_cookie_banner(driver):
    try:
        print("Dismissing cookie banner...")
        # Look for the accept button in the cookie banner
        cookie_button = WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.CSS_SELECTOR, "button[aria-label*='Accept'], button:contains('Accept'), [class*='accept']"))
        )
        cookie_button.click()
        time.sleep(1)
    except:
        # If that doesn't work, try finding any button with "Accept" text
        try:
            buttons = driver.find_elements(By.TAG_NAME, "button")
            for btn in buttons:
                if "accept" in btn.text.lower() or "agree" in btn.text.lower():
                    btn.click()
                    time.sleep(1)
                    break
        except:
            print("Could not dismiss cookie banner, continuing anyway...")