require_relative '../spec_helper'

describe Homer::Controller do

  let(:homer_service) { Homer::Controller }
  describe :api_fqdn do
    subject { lambda{ homer_service.api_fqdn } }
    it { should raise_exception(NotImplementedError) }
  end
  describe :on do
    subject { lambda{ homer_service.on("") } }
    it { should raise_exception(NotImplementedError) }
  end
  describe :off do
    subject { lambda{ homer_service.off("") } }
    it { should raise_exception(NotImplementedError) }
  end
  describe :set do
    subject { lambda{ homer_service.set("") } }
    it { should raise_exception(NotImplementedError) }
  end

end
