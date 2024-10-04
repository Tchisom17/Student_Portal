import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StudentPortalModule = buildModule("StudentPortalModule", (m) => {
  const studentPortal = m.contract("StudentPortal");

  return { studentPortal };
});

export default StudentPortalModule;
