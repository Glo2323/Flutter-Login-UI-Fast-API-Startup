from pydantic import BaseSettings

class Settings(BaseSettings):
    APP_NAME: str = "Auth Backend"
    SECRET_KEY: str = "your_jwt_secret_key_here"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    ALGORITHM: str = "HS256"
    DATABASE_URL: str = "sqlite:///./auth.db"

settings = Settings()
