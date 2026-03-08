Vibe check this React component for a settings panel.

```tsx
// src/components/SettingsPanel.tsx
import React, { useState, useEffect, useCallback, useMemo } from "react";

interface SettingItem {
  key: string;
  value: string | boolean | number;
  type: "text" | "toggle" | "number";
}

interface SettingsSectionProps {
  title: string;
  settings: SettingItem[];
  onUpdate: (key: string, value: string | boolean | number) => void;
}

const SettingsSection: React.FC<SettingsSectionProps> = ({
  title,
  settings,
  onUpdate,
}) => {
  return (
    <div className="settings-section">
      <h3>{title}</h3>
      {settings.map((setting) => (
        <div key={setting.key} className="setting-row">
          <label>{setting.key}</label>
          {setting.type === "toggle" ? (
            <input
              type="checkbox"
              checked={setting.value as boolean}
              onChange={(e) => onUpdate(setting.key, e.target.checked)}
            />
          ) : setting.type === "number" ? (
            <input
              type="number"
              value={setting.value as number}
              onChange={(e) => onUpdate(setting.key, Number(e.target.value))}
            />
          ) : (
            <input
              type="text"
              value={setting.value as string}
              onChange={(e) => onUpdate(setting.key, e.target.value)}
            />
          )}
        </div>
      ))}
    </div>
  );
};

export default function SettingsPanel() {
  const [settings, setSettings] = useState<SettingItem[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isSaving, setIsSaving] = useState(false);
  const [lastSaved, setLastSaved] = useState<Date | null>(null);

  useEffect(() => {
    fetch("/api/settings")
      .then((res) => res.json())
      .then((data) => {
        setSettings(data);
        setIsLoading(false);
      });
  }, []);

  const generalSettings = useMemo(
    () => settings.filter((s) => s.key.startsWith("general.")),
    [settings],
  );
  const notificationSettings = useMemo(
    () => settings.filter((s) => s.key.startsWith("notification.")),
    [settings],
  );
  const advancedSettings = useMemo(
    () => settings.filter((s) => s.key.startsWith("advanced.")),
    [settings],
  );

  const handleUpdate = useCallback(
    (key: string, value: string | boolean | number) => {
      setSettings((prev) =>
        prev.map((s) => (s.key === key ? { ...s, value } : s)),
      );
    },
    [],
  );

  const handleSave = useCallback(async () => {
    setIsSaving(true);
    await fetch("/api/settings", {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(settings),
    });
    setIsSaving(false);
    setLastSaved(new Date());
  }, [settings]);

  if (isLoading) return <div>Loading...</div>;

  return (
    <div className="settings-panel">
      <h2>Settings</h2>
      <SettingsSection
        title="General"
        settings={generalSettings}
        onUpdate={handleUpdate}
      />
      <SettingsSection
        title="Notifications"
        settings={notificationSettings}
        onUpdate={handleUpdate}
      />
      <SettingsSection
        title="Advanced"
        settings={advancedSettings}
        onUpdate={handleUpdate}
      />
      <button onClick={handleSave} disabled={isSaving}>
        {isSaving ? "Saving..." : "Save"}
      </button>
      {lastSaved && <span>Last saved: {lastSaved.toLocaleTimeString()}</span>}
    </div>
  );
}
```
