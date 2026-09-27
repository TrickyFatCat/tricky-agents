# Examples

Each example applies one rule from `SKILL.md` to a small piece of code.
The rules decide.
An example never adds a rule, and its values are not defaults.

## Delete A Comment That Repeats The Code

The delete test removes a comment a reader could write from the code.

**Before**

```ts
// Add one to the retry count.
retries += 1;
```

**After**

```ts
retries += 1;
```

## Keep The Why With Its What

The what comes first, and the why shares its sentence.
A why on its own line loses the code it explains.

**Before**

```csharp
// Sort the items.
// The inventory screen shows heavy items at the top.
items.Sort((a, b) => b.Weight.CompareTo(a.Weight));
```

**After**

```csharp
// Sorts heaviest first, because the inventory screen lists heavy items on top.
items.Sort((a, b) => b.Weight.CompareTo(a.Weight));
```

## Say What The Code Needs, Not How The Library Works

The why names what this code needs, not how the library locks its file.
Here the build and the level editor write to the same database.

**Before**

```python
# SQLite locks the whole file during a write, and other connections wait up to the timeout before they raise an error.
conn = sqlite3.connect(path, timeout=10)
```

**After**

```python
# Waits for the level editor's writes, so the build does not fail immediately.
conn = sqlite3.connect(path, timeout=10)
```

## Tell The Caller What The Declaration Hides

An interface comment gives the caller what the declaration does not show.
Here the body returns `None` for a missing file, and raises `ValueError` for a file an older editor saved.

**Before**

```python
def load_level(name: str) -> Level | None:
    """Loads the level with the given name."""
```

**After**

```python
def load_level(name: str) -> Level | None:
    """Returns None when no level file has this name.

    Raises ValueError when an older editor version saved the file.
    """
```

## Move A Body Fact Into The Body

An implementation fact moves next to the code it explains.
A sentence that narrates the body goes.
Here the header declares the function, and the `.cpp` file holds the cache check.

**Before**

```cpp
// Plays the footstep sound for the surface under the character.
// Traces down from the capsule and reads the physical material.
// Reuses the last sound on the same surface, to skip the sound lookup.
void PlayFootstep();
```

**After**

```cpp
// Plays the footstep sound for the surface under the character.
void PlayFootstep();
```

```cpp
// Reuses the last sound on the same surface, to skip the sound lookup.
if (Material == LastMaterial)
```

## Write A Tooltip For A Designer

A tooltip gives what the declaration and its annotations do not show.
Here the audio code passes the value to the music bus as decibels.

**Before**

```gdscript
## The volume of the music, which can go from -40 up to 0.
@export_range(-40.0, 0.0) var music_volume := -6.0
```

**After**

```gdscript
## Measured in decibels.
@export_range(-40.0, 0.0) var music_volume := -6.0
```

## Warn About A Copy

A value that a data file repeats gets a `WARNING` that names the copy.
The warning says first what must stay equal, then why.

**After**

```csharp
// WARNING: Must equal the version in save.json, because the loader checks both.
const int SaveVersion = 3;
```

## Use Plain Words

Idioms and filler go, and the fact stays.
Here the packer stops with an error when its output folder is missing.

**Before**

```bash
# Basically we gotta make sure the out dir is there, otherwise the packer just blows up.
mkdir -p "$out_dir"
```

**After**

```bash
# Creates the output folder first, because the packer fails without one.
mkdir -p "$out_dir"
```

## Keep A Contradiction For The User

A sentence whose fact the code contradicts stays word for word.
The report names the mismatch, because the code may be the part that is wrong.

```ts
/** Never returns more than 20 results. */
function search(query: string, limit: number): Result[] {
  return rank(query).slice(0, limit);
}
```

Nothing caps `limit` at 20.
The sentence stays, and the report says that `limit` alone sets the count.

## Correct A Wrong Word That Is Not The Fact

A wrong word outside the sentence's fact is corrected and reported.
Here `direction` is `Upload` or `Download`, and the sentence exists to explain `allowMetered`.

**Before**

```csharp
// Uploads the save even on a metered connection, because the player pressed Sync.
Sync(direction, allowMetered: true);
```

**After**

```csharp
// Syncs the save even on a metered connection, because the player pressed Sync.
Sync(direction, allowMetered: true);
```

In "Returns null when the file is missing.", the condition is the fact.
When the code returns null only for a locked file, that sentence is kept and reported.
