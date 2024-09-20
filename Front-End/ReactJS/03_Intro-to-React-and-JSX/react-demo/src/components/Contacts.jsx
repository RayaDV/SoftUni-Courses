export default function Contacts() {
    return (
        <section className="contact_section layout_padding-bottom">
        <div className="container-fluid">
          <div className="col-lg-4 col-md-5 offset-md-1">
            <div className="heading_container">
              <h2>
                Contact Us
              </h2>
            </div>
          </div>
          <div className="row">
            <div className="col-lg-4 col-md-5 offset-md-1">
              <div className="form_container">
                <form action="">
                  <div>
                    <input type="text" placeholder="Your Name" />
                  </div>
                  <div>
                    <input type="text" placeholder="Phone Number" />
                  </div>
                  <div>
                    <input type="email" placeholder="Email" />
                  </div>
                  <div>
                    <input type="text" className="message-box" placeholder="Message" />
                  </div>
                  <div className="btn_box">
                    <button>
                      SEND
                    </button>
                  </div>
                </form>
              </div>
            </div>
            <div className="col-lg-7 col-md-6 px-0">
              <div className="map_container">
                <div className="map">
                  <div id="googleMap"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    );
}