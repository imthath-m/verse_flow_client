# Verse Flow Backend Requirements Specification

## 1. System Architecture

### Technology Stack
- Java 21
- Spring Boot 3.2
- PostgreSQL 16
- Google Cloud Platform
- OpenAPI/Swagger for API documentation

### Key Components
- RESTful API controllers
- Service layer with provider abstractions
- Repository layer for data persistence
- Cloud storage integration
- External API integrations

---

## 2. Core API Endpoints

### 2.1 Quran Content Controller
```java
@RestController
@RequestMapping("/api/v1/quran")
```
- `GET /surahs` - List all surahs with metadata
- `GET /surah/{surahNumber}` - Get specific surah details
- `GET /verses/{surahNumber}/{verseNumber}` - Get verse details
- `GET /translations/{surahNumber}/{verseNumber}?language={lang}` - Get verse translation

### 2.2 Recitation Controller
```java
@RestController
@RequestMapping("/api/v1/recitations")
```
- `GET /reciters` - List available reciters
- `GET /audio/{reciterId}/{surahNumber}/{verseNumber}` - Get verse audio URL
- `POST /download` - Download verses for offline use
- `DELETE /download/{surahNumber}` - Remove downloaded surah

### 2.3 VoiceOver Controller
```java
@RestController
@RequestMapping("/api/v1/voiceover")
```
- `POST /generate` - Generate voice over for given text
- `GET /audio/{voiceoverId}` - Get generated voice over audio
- `DELETE /audio/{voiceoverId}` - Delete specific voice over

---

## 3. Data Models

### 3.1 VoiceOver Request
```json
{
  "text": "string",
  "language": "string",
  "uniqueId": "string",
  "voiceType": "string"
}
```

### 3.2 VoiceOver Response
```json
{
  "uniqueId": "string",
  "audioUrl": "string",
  "duration": "number",
  "status": "string"
}
```

---

## 4. External Integrations

### 4.1 Al Quran Cloud API
- Implementation: `AlQuranCloudProvider` implementing `QuranContentProvider` interface
- Endpoints used:
  - Surah listing
  - Verse content
  - Audio recitations
  - Translations

### 4.2 Voice Generation Service
- Implementation: `GoogleTextToSpeechProvider` implementing `VoiceGenerationProvider` interface
- Features:
  - Multiple language support
  - Voice selection
  - Natural speech synthesis

---

## 5. Storage Implementation

### 5.1 Google Cloud Storage
- **Audio Files Storage**
  - Bucket: `verse-flow-audio`
  - Structure: `/{content-type}/{language}/{unique-id}.mp3`
  - Lifecycle policies for cost optimization

### 5.2 Voice Over Caching Strategy
- **Storage:**
  - Primary storage in Google Cloud Storage
  - Use Cloud CDN for global content delivery
  - Implement cache-control headers with max-age=30 days
- **Lookup Flow:**
  1. Check database for existing voice over by uniqueId
  2. If exists, return signed URL from Cloud Storage
  3. If not exists, generate new voice over
- **Optimization:**
  - Implement storage classes transition (Standard → Nearline after 30 days)
  - Set up object lifecycle management (delete after 90 days of no access)
  - Compress audio files before storage
- **Monitoring:**
  - Track cache hit/miss ratios
  - Monitor storage costs and access patterns

### 5.3 Database Schema
```sql
-- Voice Over Metadata
CREATE TABLE voice_over_metadata (
    id VARCHAR(255) PRIMARY KEY,
    text TEXT NOT NULL,
    language VARCHAR(10) NOT NULL,
    storage_path VARCHAR(512) NOT NULL,
    duration INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_accessed TIMESTAMP
);
```

---

## 6. Provider Interfaces

### 6.1 Quran Content Provider
```java
public interface QuranContentProvider {
    List<Surah> getAllSurahs();
    Surah getSurah(int surahNumber);
    Verse getVerse(int surahNumber, int verseNumber);
    Translation getTranslation(int surahNumber, int verseNumber, String language);
}
```

### 6.2 Voice Generation Provider
```java
public interface VoiceGenerationProvider {
    VoiceOverResponse generateVoiceOver(VoiceOverRequest request);
    boolean deleteVoiceOver(String uniqueId);
    Optional<VoiceOverResponse> getExistingVoiceOver(String uniqueId);
}
```

---

## 7. Error Handling

### 7.1 Standard Error Response
```json
{
  "status": "number",
  "message": "string",
  "timestamp": "string",
  "path": "string",
  "details": ["string"]
}
```

### 7.2 Error Categories
- 400: Bad Request - Invalid parameters
- 404: Not Found - Resource unavailable
- 429: Too Many Requests - Rate limiting
- 500: Internal Server Error - System failures

---

## 8. Security Considerations

### 8.1 API Security
- Rate limiting per IP/client
- API key authentication
- CORS configuration
- Request validation

### 8.2 Storage Security
- Signed URLs for audio access
- Encrypted storage
- Access logging

---

## 9. Performance Requirements

- Response time: < 200ms for metadata operations
- Audio generation: < 2 seconds
- Concurrent requests: 100 requests/second
- Cache implementation for frequently accessed content
- Automatic scaling based on load

---

## 10. Monitoring and Logging

- Request/Response logging
- Error tracking
- Performance metrics
- Storage usage monitoring
- API usage statistics