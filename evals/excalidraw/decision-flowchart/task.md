Apply the /excalidraw skill. Make a flowchart of our on-call escalation for the runbook wiki.

An alert fires. If it is a P3, file a ticket and stop. Otherwise page the primary.
If the primary acknowledges within 5 minutes, they handle it. If not, page the
secondary. If the secondary does not acknowledge within 5 minutes, page the
engineering manager. Once anyone acknowledges, they decide whether it is a real
incident. If yes, open an incident channel and start the incident process. If
no, close the alert and note the false positive for tuning.

Save it as `escalation.excalidraw`.
