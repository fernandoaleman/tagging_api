# Tagging API

The Tagging API can store, retrieve, delete and report stats on the usage of a "tag" across different entities via json.

## Installation

```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rails server
```

## Usage

### Create an Entity

```
POST /tag

- Parameters
* entity_type: (String)
* entity_id: (String)
* tags: (Array)

- If the entity already exists it will replace it and all tags
```

### Retrieve an Entity

```
GET /tags/:entity_type/:entity_id

- Returns a JSON representation of the entity and it's tags
```

### Delete an Entity

```
DELETE /tags/:entity_type/:entity_id

- Completely deletes the entity and tags
```

### Retrieve Stats about all Tags

```
GET /stats

- Retrives statistics about all tags

e.g. [{tag: 'hat', count: 5}, {tag: 'fish', count: 3}]
```

### Retrieve Stats about a specific Entity

```
GET /stats/:entity_type/:entity_id

- Returns a JSON representation of the entity and it's tags
