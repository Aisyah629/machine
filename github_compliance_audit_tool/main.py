#!/usr/bin/env python3
"""
GitHub Compliance Audit Tool

This tool monitors data extraction patterns, enforces rate-limiting compliance,
and generates real-time legal risk assessments to ensure adherence to GitHub's
Terms of Service.
"""

import time
import json
import logging
from datetime import datetime
from typing import Dict, List, Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("compliance_audit.log"),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


class ComplianceMonitor:
    def __init__(self, rate_limit_threshold: float = 0.8):
        self.rate_limit_threshold = rate_limit_threshold
        self.last_request_time: Optional[datetime] = None
        self.request_history: List[datetime] = []
        self.compliance_violations: List[str] = []
        self.audit_active = True

    def log_request(self):
        """Records a data extraction request for rate-limit analysis."""
        now = datetime.utcnow()
        self.request_history.append(now)
        # Keep only the last 60 requests for sliding window analysis
        if len(self.request_history) > 60:
            self.request_history.pop(0)

    def check_rate_limit_compliance(self) -> bool:
        """Checks if current request velocity exceeds configured thresholds."""
        if not self.request_history:
            return True

        recent_requests = self.request_history[-10:]
        if len(recent_requests) < 2:
            return True

        time_span = (recent_requests[-1] - recent_requests[0]).total_seconds()
        if time_span <= 0:
            return False

        requests_per_second = len(recent_requests) / time_span
        threshold_rps = 1.0 / (60.0 / self.rate_limit_threshold)

        if requests_per_second > threshold_rps:
            violation = f"Rate limit exceeded: {requests_per_second:.2f} req/s > {threshold_rps:.2f} req/s"
            self.compliance_violations.append(violation)
            logger.warning(violation)
            return False
        return True

    def validate_permission_scope(self, requested_scope: str) -> bool:
        """Validates if the requested data scope aligns with granted permissions."""
        allowed_scopes = ["repo", "read:org", "public_repo", "read:user"]
        if requested_scope not in allowed_scopes:
            violation = f"Scope validation failed: '{requested_scope}' not in {allowed_scopes}"
            self.compliance_violations.append(violation)
            logger.warning(violation)
            return False
        return True

    def generate_risk_assessment(self) -> Dict:
        """Generates a real-time legal risk assessment report."""
        report = {
            "timestamp": datetime.utcnow().isoformat(),
            "total_requests_analyzed": len(self.request_history),
            "compliance_violations_count": len(self.compliance_violations),
            "recent_violations": self.compliance_violations[-5:],
            "risk_level": "HIGH" if len(self.compliance_violations) > 3 else "MEDIUM" if len(self.compliance_violations) > 1 else "LOW",
            "compliance_status": "ACTIVE" if not self.compliance_violations else "AT_RISK"
        }
        logger.info(f"Risk Assessment Generated: {json.dumps(report, indent=2)}")
        return report

    def halt_operations(self, reason: str):
        """Automatically halts operations when policy boundaries are approached."""
        logger.critical(f"OPERATIONS HALTED: {reason}")
        self.audit_active = False
        raise SystemExit("Compliance boundary exceeded. Operations halted per policy.")


def run_audit_cycle(monitor: ComplianceMonitor):
    """Simulates a single audit cycle for data extraction monitoring."""
    if not monitor.audit_active:
        logger.info("Audit is not active. Halting.")
        return

    monitor.log_request()
    is_compliant = monitor.check_rate_limit_compliance()

    if not is_compliant:
        monitor.halt_operations("Continuous rate-limit violations detected")

    # Example scope validation
    scope = "repo"
    if not monitor.validate_permission_scope(scope):
        monitor.halt_operations("Invalid permission scope detected")

    assessment = monitor.generate_risk_assessment()
    print(json.dumps(assessment, indent=2))


def main():
    logger.info("Initializing GitHub Compliance Audit Tool...")
    monitor = ComplianceMonitor(rate_limit_threshold=0.75)

    try:
        for i in range(1, 6):  # Simulate 5 audit cycles
            logger.info(f"Running Audit Cycle {i}/5")
            run_audit_cycle(monitor)
            time.sleep(1)
    except SystemExit as e:
        logger.error(e)
    except Exception as e:
        logger.error(f"Unexpected error during audit: {e}")
        monitor.generate_risk_assessment()

    logger.info("Audit cycle completed.")


if __name__ == "__main__":
    main()
